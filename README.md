# SBWT k-mer counters

This code is used as a preprocessing step in [MTB++](https://github.com/M-Serajian/MTB-plus-plus) which is an antimicrobial resistance detector tool for mycobacterium tuberculosis. 

# Compiling dependencies

This code depends on the SBWT library. Compile SBWT with:

```
git submodule update --init --recursive
cd SBWT/build
cmake ..
make -j
```

If there are problems, read the README file in the SBWT subdirectory for help.

# Compiling the tool

Compile this code by running `make counters dump_kmers multi_genome_counters`. Then, to build the SBWT index and find all the non-zero counters for all k-mers, run the pipeline:

```
# Build the SBWT index
./SBWT/build/bin/sbwt build --in-file in_file_list.txt -k 31 -o index.sbwt -t 8 -m 10 --temp-dir temp

# Build the counters
./counters index.sbwt in_file_list.txt >multi_genome_color_matrix.txt
```
