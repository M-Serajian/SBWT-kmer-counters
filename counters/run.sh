set -xue

# Create list of input genomes
find genomes -type f > in_file_list.txt

# Build the SBWT index
../build/bin/sbwt build --in-file in_file_list.txt -k 31 -out index.sbwt -t 8 -m 10 --temp-dir temp

# Build the counters
./counters ../index.sbwt genomes/*.fna
