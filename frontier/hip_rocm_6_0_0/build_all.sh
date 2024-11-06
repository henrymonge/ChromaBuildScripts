#!/bin/bash
source ./env.sh
#
# Seemingly QDPXX finds an installed one so no need to build this
# ./build_libxml2.sh 
 
./build_qmp.sh
./build_hdf5.sh
./build_qdpxx.sh
./build_qdpxx_h5.sh
./build_quda.sh
./build_chroma_h5.sh
./build_lalibe_gpu.sh
