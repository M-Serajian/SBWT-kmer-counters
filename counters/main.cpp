#include "sbwt/SBWT.hh"
#include "sbwt/variants.hh"

using namespace sbwt;

typedef plain_matrix_sbwt_t sbwt_t;

struct Counter{

    int32_t color;
    int32_t count;

};

int main(int argc, char** argv){

    string indexfile = argv[1];

    throwing_ifstream in(indexfile, ios::binary);
    string variant = load_string(in.stream); // read variant type
    if(variant != "plain-matrix"){
        cerr << "Error: this code only supports the plain matrix variant" << endl;
        return 1;
    }

    cerr << "Loading SBWT from " << indexfile << endl;
    sbwt_t sbwt;
    sbwt.load(in.stream);

    cerr << "SBWT loaded" << endl;

    int64_t sbwt_length = sbwt.number_of_subsets();

    vector<vector<Counter>> counters(sbwt_length); // K-mer handle -> list of counters

    vector<bool> kmer_handles_found(sbwt_length); // Bit vector that marks which k-mer handles have at least 1 counter

    // Arguments 2..(argc-1) are sequence files from which we want to compute the k-mer counts
    for(int64_t i = 2; i < argc; i++){
        int32_t color = i - 2; 
        string filename = argv[i];
        SeqIO::Reader<> reader(filename);
        while(true){
            int64_t length = reader.get_next_read_to_buffer();
            if(length == 0) break; // All sequences have been read

            const char* seq = reader.read_buf; // The DNA sequence

            // Search all k-mers of seq
            vector<int64_t> handles = sbwt.streaming_search(seq, length);

            for(int64_t handle : handles){
                if(handle == -1) continue; // This k-mer does not exist in the index
                if(counters[handle].size() == 0 || counters[handle].back().color != color){
                    // No counter yet for this k-mer and this color
                    Counter C = {.color = color, .count = 0}; // Create a counter
                    counters[handle].push_back(C);
                    kmer_handles_found[handle] = 1;
                }
                counters[handle].back().count++; // Add to the count of this color in this k-mer
            }
        }
    }

    for(int64_t i = 0; i < counters.size(); i++){
        if(kmer_handles_found[i]){
            cout << i;
            for(Counter C : counters[i]){
                cout << " (" << C.color << ": " << C.count << ")";
            }
            cout << "\n";
        }
    }
}