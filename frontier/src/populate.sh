#!/bin/bash

git clone https://github.com/usqcd-software/qmp.git

git clone -b hdf5-1_10_9 git@github.com:HDFGroup/hdf5.git hdf5-1.10.9

git clone --recursive -b devel https://github.com/usqcd-software/qdpxx.git

git clone --recursive -b devel https://github.com/jeffersonlab/qdp-jit.git

git clone -b develop https://github.com/lattice/quda.git

git clone --recursive -b devel https://github.com/jeffersonlab/chroma.git

git clone --recursive -b qedm https://github.com/callat-qcd/lalibe.git

