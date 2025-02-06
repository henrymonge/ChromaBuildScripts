module purge
module load DefApps-spi
module load cpe/24.07
module load PrgEnv-cray/8.5.0
module load amd/6.3.1
module load rocm/6.3.1
module load craype-accel-amd-gfx90a
module load cray-mpich/8.1.31
module load cmake
module load cray-hdf5-parallel/1.12.2.9
module load gcc-mixed/12.2.0
module load libfabric/1.15.2.0
module load ninja/1.11.1
module load xpmem/2.8.4-1.0_7.3__ga37cbd9.shasta
module list

export MPICH_ROOT=/opt/cray/pe/mpich/8.1.31
export GTL_ROOT=/opt/cray/pe/mpich/8.1.31/gtl/lib
export MPICH_DIR=${MPICH_ROOT}/ofi/amd/6.0

QMP=qmp
CHROMA=chroma_cpu
CHROMA_SRC=chroma
QDP=qdpxx_h5
QDP_SRC=qdpxx
H5=ON
QUDA=quda
QUDA_SRC=quda
LALIBE=lalibe_cpu
LALIBE_SRC=lalibe


CC=cc
CXX=CC

## These must be set before running

export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/../src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install
export TARGET_GPU=gfx90a

MPI_CFLAGS="${CRAY_XPMEM_INCLUDE_OPTS} -I${MPICH_DIR}/include -I${ROCM_PATH}/include/hipblas -I${ROCM_PATH}/include/hipfft"
MPI_LDFLAGS="-L/opt/cray/libfabric/1.15.2.0/lib64  -Wl,--rpath=/opt/cray/libfabric/1.15.2.0/lib64 ${CRAY_XPMEM_POST_LINK_OPTS} -lxpmem  -Wl,-rpath=${MPICH_DIR}/lib -L${MPICH_DIR}/lib -lmpi -Wl,-rpath=${GTL_ROOT} -L${GTL_ROOT} -lmpi_gtl_hsa -L${HDF5_ROOT}/lib -lhdf5"

export PK_BUILD_TYPE="Release"

export PATH=${ROCM_PATH}/bin:${PATH}
    
export LD_LIBRARY_PATH=${HDF5_ROOT}/lib:${INSTALLROOT}/${CHROMA}/lib:${INSTALLROOT}/${QUDA}/lib:${INSTALLROOT}/${QDP}/lib:${INSTALLROOT}/${QMP}/lib:${ROCM_PATH}/lib:${MPICH_DIR}/lib:${GTL_ROOT}:/opt/cray/libfabric/1.15.2.0/lib64:${LD_LIBRARY_PATH}

export LIBRARY_PATH=${ROCM_PATH}/include:${LIBRARY_PATH}:${HDF5_ROOT}/include

