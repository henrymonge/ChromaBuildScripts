module load cuda/11.5.2
module load cmake
module load gcc/11.2.0
module load ninja

export GCC_HOME=${OLCF_GCC_ROOT}
export TOPDIR_HIP=/gpfs/alpine/proj-shared/stf006/bjoo/ChromaTestbuild-6-3-22/cuda-jit
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install
export LD_LIBRARY_PATH=${INSTALLROOT}/chroma/lib:${INSTALLROOT}/quda/lib:${INSTALLROOT}/qdpxx/lib:${INSTALLROOT}/qmp/lib:${INSTALLROOT}/llvm-13/lib:${LD_LIBRARY_PATH}

export CUDA_HOME=$CUDA_DIR
export MPI_HOME=$MPI_ROOT
