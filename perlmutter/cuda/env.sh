module purge
module load PrgEnv-gnu
module load cuda/12.4
module load gcc/12.2.0
#module load mpich/3.2.1-gcc
#module load openmpi/5.0.0
module load mpich/4.2.2
module load cmake/3.30.2

module list

export GCC_HOME=$GCC_PATH


export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install

#Here we need to pass the library paths
export LD_LIBRARY_PATH=${INSTALLROOT}/chroma/lib:${INSTALLROOT}/quda/lib:${CUDA_HOME}/lib64:${INSTALLROOT}/qdpxx/lib:${INSTALLROOT}/qmp/lib:${LD_LIBRARY_PATH}

export MPI_HOME=${MPI_ROOT} #/opt/tools/mpich-3.2.1
