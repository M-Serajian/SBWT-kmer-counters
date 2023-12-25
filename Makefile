SDSL_INCLUDES=-I SBWT/build/external/sdsl-lite/build/include
DIVSUFSORT_INCLUDES=-I SBWT/build/external/sdsl-lite/build/external/libdivsufsort/include
SEQIO_INCLUDES=-I SBWT/build/external/SeqIO/include
SBWT_INCLUDES=-I SBWT/include -I SBWT/include/sbwt 

ALL_INCLUDES=${SDSL_INCLUDES} ${DIVSUFSORT_INCLUDES} ${SEQIO_INCLUDES} ${SBWT_INCLUDES}

SBWT_LIBS=-L $(shell pwd)/SBWT/build/external/sdsl-lite/build/lib/

all: 
	${CXX} -g -std=c++2a -O3 single_genome.cpp SBWT/build/libsbwt_static.a ${ALL_INCLUDES} ${SBWT_LIBS} -lsdsl -lz -o single_genome.cpp -Wno-deprecated-declarations
	${CXX} -g -std=c++2a -O3 dump_kmers.cpp SBWT/build/libsbwt_static.a ${ALL_INCLUDES} ${SBWT_LIBS} -lsdsl -lz -o dump_kmers -Wno-deprecated-declarations	
	${CXX} -g -std=c++2a -O3 multi_genome_counters.cpp SBWT/build/libsbwt_static.a ${ALL_INCLUDES} ${SBWT_LIBS} -lsdsl -lz -o multi_genome_counters -Wno-deprecated-declarations
