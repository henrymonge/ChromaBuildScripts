#!/bin/bash

source ./env.sh

if [[ ! -d $SRCROOT ]]; then
    mkdir $SRCROOT
fi

if [[ ! -d $SRCROOT/qmp ]]; then
    pushd $SRCROOT
    git clone https://github.com/usqcd-software/qmp.git
    popd
fi

if [[ ! -d $SRCROOT/qdpxx ]]; then
    pushd $SRCROOT
    git clone --recursive -b devel https://github.com/usqcd-software/qdpxx.git
    popd
fi

if [[ ! -d $SRCROOT/quda ]]; then
    pushd $SRCROOT
    git clone -b develop https://github.com/lattice/quda.git
    popd
fi


if [[ ! -d $BUILDROOT ]]; then
    mkdir $BUILDROOT
fi

./build_qmp.sh
./build_qdpxx.sh
#./build_quda.sh





