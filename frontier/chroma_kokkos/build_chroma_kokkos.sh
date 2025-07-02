source ./env_kokkos.sh
pushd ${BUILDROOT}

if [ -d ./build_chroma_kokkos ];
then
  rm -rf ./build_chroma_kokkos
fi

mkdir  ./build_chroma_kokkos
cd ./build_chroma_kokkos


Kokkos_SOURCE_DIR=${SRCROOT}/${CHROMA_SRC}/lib/kokkos_src
export PATH=${SRCROOT}/${CHROMA_SRC}/lib/kokkos_src/bin:${PATH}


echo ${SRCROOT}/${CHROMA_SRC}
cmake ${SRCROOT}/${CHROMA_SRC} -DCMAKE_CXX_COMPILER=${CXX} -DCMAKE_CXX_STANDARD=20 \
		-DCMAKE_C_COMPILER=${CC} -DCMAKE_C_STANDARD=99 -DCMAKE_C_EXTENSIONS=OFF  \
	 	-DBUILD_SHARED_LIBS=ON \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo \
		-DQDPXX_DIR=${INSTALLROOT}/${QDP}/lib/cmake/QDPXX \
		-DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP \
        -DCMAKE_CXX_FLAGS="${MPI_CFLAGS} -std=c++20" \
		-DChroma_ENABLE_OPENMP=ON \
        -DCMAKE_SHARED_LINKER_FLAGS="${MPI_LDFLAGS}" \
		-DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${CHROMA} \
        -DChroma_ENABLE_JIT_CLOVER=ON \
        -DLLVM_DIR=${ROCM_PATH}/llvm/lib/cmake/llvm \
        -DLLD_DIR=${ROCM_PATH}/llvm/lib/cmake/lld \
        -DChroma_ENABLE_KOKKOS=${KOKKOS} \
        -DKokkos_ROOT=${OLCF_KOKKOS_ROOT}/lib64/cmake/Kokkos \
        -DKokkos_SOURCE_DIR=${Kokkos_SOURCE_DIR} \
        -DKokkos_INCLUDE_DIRS=${SRCROOT}/${CHROMA_SRC}/lib/kokkos_src \
        -DKokkos_ENABLE_HIP=ON \
        -DKokkos_ARCH_VEGA90A=ON

cmake --build . -v -j 32 
cmake --install .

popd
