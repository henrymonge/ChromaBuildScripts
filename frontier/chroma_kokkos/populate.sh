#!/bin/bash

mkdir ../src
pushd ../src

git clone https://github.com/usqcd-software/qmp.git

git clone --recursive -b devel https://github.com/jeffersonlab/qdp-jit.git

pushd qdp-jit
sed -i 's#find_package(LLVM "18.1" REQUIRED CONFIG)#  find_package(LLVM "18.0" REQUIRED CONFIG)#g' CMakeLists.txt 
sed -i 's#find_package(LLVM "18.1" REQUIRED CONFIG)#  find_package(LLVM "18.0" REQUIRED CONFIG)#g' QDPXXConfig.cmake.in 
popd

git clone -b mesons_kokkos git@github.com:henrymonge/devel_kokkos.git

pushd devel_kokkos/other_libs
git clone git@github.com:JeffersonLab/cpp_wilson_dslash.git
popd

pushd devel_kokkos/other_libs
git clone git@github.com:JeffersonLab/qdp-lapack.git
popd

pushd devel_kokkos/other_libs
git clone git@github.com:JeffersonLab/sse_wilson_dslash.git
popd

pushd devel_kokkos/other_libs
git clone git@github.com:JeffersonLab/wilsonmg.git
popd


popd

mkdir build
