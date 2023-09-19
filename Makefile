SBWT_INCLUDES=-I $(shell pwd)/SBWT/sdsl-lite/include -I $(shell pwd)/SBWT/SeqIO/include -I $(shell pwd)/SBWT/include -I $(shell pwd)/SBWT/include/sbwt -I $(shell pwd)/SBWT/build/external/sdsl-lite/build/external/libdivsufsort/include
SBWT_LIBS=-L $(shell pwd)/SBWT/build/external/sdsl-lite/build/lib/

counters:
	g++-9 -g -std=c++2a -O3 main.cpp SBWT/build/libsbwt_static.a ${SBWT_INCLUDES} ${SBWT_LIBS} -lsdsl -lz -o counters -Wno-deprecated-declarations

dump_kmers:
	g++-9 -g -std=c++2a -O3 dump_kmers.cpp SBWT/build/libsbwt_static.a ${SBWT_INCLUDES} ${SBWT_LIBS} -lsdsl -lz -o dump_kmers -Wno-deprecated-declarations	

multi_genome_counters:
	g++-9 -g -std=c++2a -O3 multi_genome_counters.cpp SBWT/build/libsbwt_static.a ${SBWT_INCLUDES} ${SBWT_LIBS} -lsdsl -lz -o multi_genome_counters -Wno-deprecated-declarations
