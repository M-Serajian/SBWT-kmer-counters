all:
	g++ -g -std=c++20 -O3 main.cpp ../build/lib/libsbwt_static.a -L ../build/lib -I ../include/sbwt -I ../sdsl-lite/include -I ../build/external/sdsl-lite/build/external/libdivsufsort/include -I ../include -lsdsl -lz -o counters -Wno-deprecated-declarations

dump_kmers:
	g++ -g -std=c++20 -O3 dump_kmers.cpp ../build/lib/libsbwt_static.a -L ../build/lib -I ../include/sbwt -I ../sdsl-lite/include -I ../build/external/sdsl-lite/build/external/libdivsufsort/include -I ../include -lsdsl -lz -o dump_kmers -Wno-deprecated-declarations	