# Before running this script, you need to build the Docker image with:
# docker build . -t counters:v1

set -xue

### Parameters ###

# Output file
COUNTERS_OUTPUT_FILE=counters.txt

# An ABSOLUTE PATH to a text file containing the list of input sequence files, one per line.
INPUT_SEQ_LISTFILE=<PATH/TO/LISTFILE/HERE>

# An ABSOLUTE PATH to the directory for temporary files. Ideally a fast SSD drive with lots of space.
TEMP_DIR=<PATH/TO/TEMP/DIR/HERE>

# The k of the k-mers
KMER_K=31

# Number of parallel threads
THREADS=8

### Commands ###

# Prepend "/mount/" to the file paths to map to the file system of the container
cat $INPUT_SEQ_LISTFILE | awk '{print "/mount/"$0}' > $TEMP_DIR/listfile.txt

# Build the SBWT, mapping the local filesystem root to /mount in the container
docker run -v /:/mount counters:v1 /SBWT-kmer-counters/build/bin/sbwt build -i /mount/$TEMP_DIR/listfile.txt -o /mount/$TEMP_DIR/kmers.sbwt -k $KMER_K --temp-dir /mount/$TEMP_DIR

# Build the counters
docker run -v /:/mount counters:v1 /SBWT-kmer-counters/counters/counters /mount/$TEMP_DIR/kmers.sbwt /mount/$TEMP_DIR/listfile.txt > $COUNTERS_OUTPUT_FILE

echo Counters written to $COUNTERS_OUTPUT_FILE
