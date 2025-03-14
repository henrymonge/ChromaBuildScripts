#!/bin/bash
#
#################
# BUILD GLU
#################

source ./env.sh

module purge
module load craype-x86-milan
module load cray-fftw/3.3.10.3
module load gcc/12.2.0

#module load gcc/8.3.1
#module load fftw/3.3.9


module list

src_name=GLU
build_name=GLU
install_name=GLU


pushd ${BUILDROOT}

if [ -d ./$build_name ]; 
then 
  rm -rf ./$build_name
fi

mkdir  ./$build_name
cd ./$build_name

###	LDFLAGS="-Wl,-zmuldefs -L${CUDA_HOME}/lib64" \

echo "configuring GLU"
echo "HOST: $HOST"
sleep 2

autoreconf -f -i

pwd
# make without SYMANZIK to do STOUT/HEX smearing

echo "$SRCROOT/GLU/configure --prefix=${INSTALLROOT}/$install_name CC=gcc CFLAGS="-O3 -fopenmp -Wall -msse4.2 -mfma" --enable-GIVENS_APE --with-fftw=/usr/tcetmp/packages/fftw/fftw-3.3.10-xl-2023.06.28"

echo "$SRCROOT/GLU/configure --prefix=${INSTALLROOT}/$install_name CC=gcc CFLAGS="-O3 -fopenmp -Wall" --with-fftw=/usr/tcetmp/packages/fftw/fftw-3.3.10-xl-2023.06.28
make; make install"

$SRCROOT/GLU/configure --prefix=${INSTALLROOT}/$install_name CC=gcc CFLAGS="-O3 -fopenmp -Wall" --enable-GIVENS_APE --with-fftw=usr/tcetmp/packages/fftw/fftw-3.3.9
make; make install



popd


printf "\nSRC BUILD INSTALL DIRS\n"
echo "src: $SRCROOT/$src_name"
echo "build: $BUILDDIR/$build_name"
echo "install: $INSTALLROOT/$install_name"
