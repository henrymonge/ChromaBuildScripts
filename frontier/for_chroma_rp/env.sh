module load PrgEnv-amd
module load amd/6.0.0
module load rocm/6.0.0
module load craype-accel-amd-gfx90a
module load cray-mpich/8.1.28
module load cmake
module load gcc-mixed/12.2.0
module load ninja
module list

export MPICH_ROOT=/opt/cray/pe/mpich/8.1.28
export GTL_ROOT=/opt/cray/pe/mpich/8.1.28/gtl/lib
export MPICH_DIR=${MPICH_ROOT}/ofi/amd/5.0
export LIBDEVICE="-libdevice-path /opt/rocm-6.0.0/llvm/lib -libdevice-name libomptarget-new-amdgpu-gfx90a.bc"
export LD_LIBRARY_PATH=/sw/frontier/spack-envs/base/opt/linux-sles15-x86_64/gcc-7.5.0/zstd-1.5.0-fffxf5wbot6b25clhjf66d53xmdbqeo3/lib:$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH

CHROMA=chroma
CHROMA_SRC=chroma
QDP_SRC=qdpxx
JIT=OFF
QDP=qdpxx
QMP=qmp
QUDA=quda
QUDA_SRC=quda


CC=hipcc
CXX=hipcc

## These must be set before running
export TOPDIR_HIP=`pwd`
export SRCROOT=${TOPDIR_HIP}/src
export BUILDROOT=${TOPDIR_HIP}/build
export INSTALLROOT=${TOPDIR_HIP}/install
export TARGET_GPU=gfx90a

MPI_CFLAGS="${CRAY_XPMEM_INCLUDE_OPTS} -I${MPICH_DIR}/include -I${ROCM_PATH}/include/hipblas -I/opt/${ROCM_PATH}/include/hipfft"
MPI_LDFLAGS="-L/opt/cray/libfabric/1.15.0.0/lib64  -Wl,--rpath=/opt/cray/libfabric/1.15.0.0/lib64 ${CRAY_XPMEM_POST_LINK_OPTS} -lxpmem  -Wl,-rpath=${MPICH_DIR}/lib -L${MPICH_DIR}/lib -lmpi -Wl,-rpath=${GTL_ROOT} -L${GTL_ROOT} -lmpi_gtl_hsa -L${ROCM_PATH}/llvm/lib -Wl,-rpath=${ROCM_PATH}/llvm/lib"

export PK_BUILD_TYPE="Release"

export PATH=${ROCM_PATH}/bin:${ROCM_PATH}/llvm/bin:${PATH}
    
export LD_LIBRARY_PATH=${INSTALLROOT}/${CHROMA}/lib:${INSTALLROOT}/${QUDA}/lib:${INSTALLROOT}/${QDP}/lib:${INSTALLROOT}/${QMP}/lib:${ROCM_PATH}/lib:${ROCM_PATH}/llvm/lib:${MPICH_DIR}/lib:${GTL_ROOT}:/opt/cray/libfabric/1.15.0.0/lib64:${LD_LIBRARY_PATH}


export LIBRARY_PATH=${ROCM_PATH}/include:${LIBRARY_PATH}
