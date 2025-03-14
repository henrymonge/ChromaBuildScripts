module purge
module load PrgEnv-gnu
module load cuda/12.4
module load gcc/12.2.0
#module load mpich/3.2.1-gcc
#module load openmpi/5.0.0
module load mpich/4.2.2
module load cmake/3.30.2
module load cray-hdf5-parallel/1.12.2.9

module list

QMP=qmp
QDP=qdpxx
QUDA=quda
CHROMA=chroma
LALIBE=lalibe
H5=ON

export GCC_HOME=$GCC_PATH

CC=mpicc
CXX=mpicxx

export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install

LALIBE_GPU=${INSTALLROOT}/${LALIBE}/bin/lalibe



#Here we need to pass the library paths
export LD_LIBRARY_PATH=${HDF5_ROOT}/lib:${INSTALLROOT}/${CHROMA}/lib:${INSTALLROOT}/${QUDA}/lib:${CUDA_HOME}/lib64:${INSTALLROOT}/${QDP}/lib:${INSTALLROOT}/${QMP}/lib:${LD_LIBRARY_PATH}

export MPI_HOME=${MPI_ROOT} #/opt/tools/mpich-3.2.1
