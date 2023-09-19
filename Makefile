counters:
	g++-9 -g -std=c++2a -O3 main.cpp ../build/lib/libsbwt_static.a -L ../build/lib -I ../include/sbwt -I ../../SeqIO/include -I ../sdsl-lite/include -I ../build/external/sdsl-lite/build/external/libdivsufsort/include -I ../include -lsdsl -lz -o counters -Wno-deprecated-declarations

dump_kmers:
	g++-9 -g -std=c++2a -O3 dump_kmers.cpp ../build/lib/libsbwt_static.a -L ../build/lib -I ../include/sbwt -I ../sdsl-lite/include -I ../../SeqIO/include -I ../build/external/sdsl-lite/build/external/libdivsufsort/include -I ../include -lsdsl -lz -o dump_kmers -Wno-deprecated-declarations	

multi_genome_counters:
	g++-9 -g -std=c++2a -O3 multi_genome_counters.cpp ../build/lib/libsbwt_static.a -L ../build/lib -I ../include/sbwt -I ../../SeqIO/include -I ../sdsl-lite/include -I ../build/external/sdsl-lite/build/external/libdivsufsort/include -I ../include -lsdsl -lz -o multi_genome_counters -Wno-deprecated-declarations
