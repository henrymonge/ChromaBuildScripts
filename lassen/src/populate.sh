#!/bin/bash

git clone https://github.com/usqcd-software/qmp.git

git clone --recursive -b devel https://github.com/usqcd-software/qdpxx.git

git clone --recursive -b devel https://github.com/jeffersonlab/qdp-jit.git

git clone -b develop https://github.com/lattice/quda.git

git clone --recursive -b devel https://github.com/jeffersonlab/chroma.git

#git clone -b release/13.x https://github.com/llvm/llvm-project

