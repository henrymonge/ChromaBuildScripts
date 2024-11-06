#!/bin/bash
source ./env.sh
#
# Seemingly QDPXX finds an installed one so no need to build this
# ./build_libxml2.sh 
 
./build_qmp.sh > out_build_qmp.sh 2>&1
./build_hdf5.sh > out_build_hdf5.sh 2>&1
./build_qdpxx.sh > out_build_qdpxx.sh 2>&1
./build_qdpxx_h5.sh > out_build_qdpxx_h5.sh 2>&1
./build_quda.sh > out_build_quda.sh 2>&1
./build_chroma_h5.sh > out_build_chroma_h5.sh 2>&1
./build_lalibe_gpu.sh > out_build_lalibe_gpu.sh 2>&1
