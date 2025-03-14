#!/bin/bash

git clone https://github.com/usqcd-software/qmp.git

git clone --recursive -b devel https://github.com/usqcd-software/qdpxx.git

#git clone --recursive -b devel https://github.com/jeffersonlab/qdp-jit.git

git clone -b develop https://github.com/lattice/quda.git

git clone --recursive -b devel https://github.com/jeffersonlab/chroma.git
cd chroma
git checkout 3ae4e0d
cd ../

git clone git@github.com:RJHudspith/GLU.git

git clone --recursive -b qedm https://github.com/callat-qcd/lalibe.git

