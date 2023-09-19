set -xue

# Build the SBWT index
../build/bin/sbwt build --in-file in_file_list.txt -k 31 -o index.sbwt -t 8 -m 10 --temp-dir temp

# Build the counters
./counters index.sbwt in_file_list.txt >multi_genome_color_matrix.txt
