module load cuda/12.0.0
module load cmake/3.21.1
module load gcc/12.2.1
module load ninja/1.9.0

HDF5=hdf5-1.10.9
CXX=mpicxx
CC=mpicc
CHROMA_SRC=chroma
CHROMA=chroma
QUDA_SRC=quda
QUDA_SRC=quda
QMP=qmp
QDP_SRC=qdpxx
QDP=qdpxx
LALIBE_SRC=lalibe_production
LALIBE_CPU=lalibe
LALIBE=lalibe_gpu

CC=mpicc
CXX=mpicxx

HDF5=hdf5-1.10.9
H5=OFF

echo "Stack ${1}"
if [ "$1" = "H5" ]; then
  H5=ON
  CHROMA=chroma_H5
  QDP=qdpxx_H5
  QUDA=quda_H5
  LALIBE_CPU=lalibe_H5
  LALIBE=lalibe_gpu_H5
   
fi
echo "Using/Setting up stack: ${CHROMA} ${QDP} ${QMP} ${QUDA}  Srcs: ${CHROMA_SRC} ${QUDA_SRC}"



export TOPDIR_HIP=/usr/workspace/coldqcd/software/lassen_smpi_RR_hm/software/cuda
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install
export LD_LIBRARY_PATH=${INSTALLROOT}/hdf5-1.10.9/lib:/usr/tce/packages/cuda/cuda-12.0.0/lib64:${INSTALLROOT}/${CHROMA}/lib:${INSTALLROOT}/${QUDA}/lib:${INSTALLROOT}/${QDP}/lib:${INSTALLROOT}/${QMP}/lib:${LD_LIBRARY_PATH}

#export CUDA_HOME=$CUDA_DIR
export CUDA_DIR=$CUDA_HOME
export MPI_HOME=$MPI_ROOT
