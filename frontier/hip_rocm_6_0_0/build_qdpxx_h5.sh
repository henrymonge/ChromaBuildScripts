source ./env.sh

pushd ${SRCROOT}/${QDP_SRC}

COMMIT=`git rev-parse --short HEAD`
echo "${QDP_SRC} commit ${COMMIT}"

#git checkout f51b9d6ea2eb584fb555c473868402dc06373815
popd

pushd ${BUILDROOT}

if [ -d ./build_${QDP} ];
then
  rm -rf ./build_${QDP}
fi

mkdir  ./build_${QDP}
cd ./build_${QDP}


echo "${SRCROOT}/${QDP_SRC}"

cmake ${SRCROOT}/${QDP_SRC} -DQDP_PARALLEL_ARCH=parscalar \
       -DQDP_PRECISION=double \
       -DCMAKE_BUILD_TYPE=${PK_BUILD_TYPE} \
       -DBUILD_SHARED_LIBS=ON \
       -DCMAKE_CXX_COMPILER=${CXX} \
       -DCMAKE_C_COMPILER=${CC}  \
       -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${QDP} \
       -DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP \
       -DCMAKE_CXX_FLAGS="${MPI_CFLAGS}" \
       -DCMAKE_C_FLAGS="${MPI_CFLAGS} " \
       -DCMAKE_SHARED_LINKER_FLAGS="${MPI_LDFLAGS} -ldl" \
       -DCMAKE_EXE_LINKER_FLAGS="${MPI_LDFLAGS} " \
       -DQDP_ENABLE_BACKEND=ROCM \
       -DQDP_ENABLE_LLVM17=ON \
       -DLLVM_DIR=${ROCM_PATH}/llvm/lib/cmake/llvm \
       -DLLD_DIR=${ROCM_PATH}/llvm/lib/cmake/lld \
	   -DQDP_PROP_OPT=OFF \
	   -DGPU_TARGETS=${TARGET_GPU} \
	   -DCMAKE_CXX_STANDARD=17 \
	   -DCMAKE_CXX_EXTENSIONS=OFF \
       -DQDP_BUILD_EXAMPLES=ON \
       -DHDF5_ROOT=${INSTALLROOT}/${HDF5} \
       -DQDP_USE_HDF5=${H5} \
	   -DQDP_AC_ALIGNMENT_SIZE=128

cmake --build . -j 32  -v
cmake --install .

popd

