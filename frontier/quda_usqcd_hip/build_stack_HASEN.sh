#!/bin/bash

source ./env.sh

if [[ ! -d $SRCROOT ]]; then
    mkdir $SRCROOT
fi

if [[ ! -d $SRCROOT/qmp ]]; then
    pushd $SRCROOT
    git clone https://github.com/usqcd-software/qmp.git
    cd qmp
    git checkout 3010fef5b5784b3e6eeec9fff38cb9954a28ad42
    popd
fi

if [[ ! -d $SRCROOT/qdpxx ]]; then
    pushd $SRCROOT
    git clone --recursive -b devel https://github.com/usqcd-software/qdpxx.git
    cd qdpxx
    git checkout 7a4bd2c2f021b0c7e3a15d48b917d75cceaff3eb
    popd
fi

if [[ ! -d $SRCROOT/quda ]]; then
    pushd $SRCROOT
    git clone -b develop https://github.com/lattice/quda.git
    cd quda
    git checkout 3414317269e568e50313680cff225c4591ec082e 
    popd
fi

if [[ ! -d $BUILDROOT ]]; then
    mkdir $BUILDROOT
fi

./build_qmp.sh
./build_qdpxx.sh
./build_quda_HASEN.sh

