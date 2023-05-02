
#include "sbwt/SBWT.hh"
#include "sbwt/variants.hh"

using namespace sbwt;

typedef plain_matrix_sbwt_t sbwt_t;

std::vector<std::string> dump_all_kmers(const sdsl::bit_vector& A_bits,
                          const sdsl::bit_vector& C_bits, 
                          const sdsl::bit_vector& G_bits, 
                          const sdsl::bit_vector& T_bits,
                          int64_t k){

    int64_t n_nodes = A_bits.size();
    vector<int64_t> C_array(4);

    vector<char> last; // last[i] = incoming character to node i
    last.push_back('$');

    C_array[0] = last.size();
    for(int64_t i = 0; i < n_nodes; i++) if(A_bits[i]) last.push_back('A');

    C_array[1] = last.size();
    for(int64_t i = 0; i < n_nodes; i++) if(C_bits[i]) last.push_back('C');

    C_array[2] = last.size();
    for(int64_t i = 0; i < n_nodes; i++) if(G_bits[i]) last.push_back('G');
    
    C_array[3] = last.size();
    for(int64_t i = 0; i < n_nodes; i++) if(T_bits[i]) last.push_back('T');

    if(last.size() != n_nodes){
        cerr << "BUG " << last.size() << " " << n_nodes << endl;
        exit(1);
    }

    vector<string> all_kmers(n_nodes);
    for(string& S : all_kmers) S.resize(k);

    for(int64_t round = 0; round < k; round++){
        cerr << "round " << round << "/" << k-1 << endl;
        for(int64_t i = 0; i < n_nodes; i++){
            all_kmers[i][k-1-round] = last[i];
        }

        // Propagate the labels one step forward in the graph
        vector<char> propagated(n_nodes, '$');
        int64_t A_ptr = C_array[0];
        int64_t C_ptr = C_array[1];
        int64_t G_ptr = C_array[2];
        int64_t T_ptr = C_array[3];
        for(int64_t i = 0; i < n_nodes; i++){
            if(A_bits[i]) propagated[A_ptr++] = last[i];
            if(C_bits[i]) propagated[C_ptr++] = last[i];
            if(G_bits[i]) propagated[G_ptr++] = last[i];
            if(T_bits[i]) propagated[T_ptr++] = last[i];
        }
        last = propagated;
    }

    return all_kmers;
}

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
    cerr << "Extracting k-mers..." << endl;

    vector<string> kmers = dump_all_kmers(
        sbwt.get_subset_rank_structure().A_bits,
        sbwt.get_subset_rank_structure().C_bits,
        sbwt.get_subset_rank_structure().G_bits,
        sbwt.get_subset_rank_structure().T_bits,
        sbwt.get_k());

    for(const string& x : kmers) cout << x << "\n";

}
