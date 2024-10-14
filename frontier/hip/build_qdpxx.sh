source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_qdpxx ];
then
  rm -rf ./build_qdpxx
fi

mkdir  ./build_qdpxx
cd ./build_qdpxx
<<'COMMENT'
#cmake ${SRCROOT}/${QDP_SRC} -G "Ninja" -DQDP_PARALLEL_ARCH=parscalar \
cmake ${SRCROOT}/${QDP_SRC} -DQDP_PARALLEL_ARCH=parscalar \
       -DQDP_PRECISION=double \
       -DCMAKE_BUILD_TYPE=RelWithDebInfo \
       -DBUILD_SHARED_LIBS=ON \
       -DCMAKE_CXX_COMPILER=${CXX} -DCMAKE_CXX_EXTENSIONS=OFF \
       -DCMAKE_C_COMPILER=${CC} -DCMAKE_C_STANDARD=99 -DCMAKE_C_EXTENSIONS=OFF \
       -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${QDP} \
       -DHDF5_ROOT=${INSTALLROOT}/${HDF5} \
       -DQDP_USE_HDF5=${H5} \
       -DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP
COMMENT

cmake ${SRCROOT}/${QDP_SRC} -DQDP_PARALLEL_ARCH=parscalar \
       -DQDP_PRECISION=double \
       -DCMAKE_BUILD_TYPE=${PK_BUILD_TYPE} \
       -DBUILD_SHARED_LIBS=ON \
       -DCMAKE_CXX_COMPILER=${CXX} \
       -DCMAKE_C_COMPILER=${CC}  \
       -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${QDP} \
       -DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP \
       -DCMAKE_CXX_FLAGS="${MPI_CFLAGS} " \
       -DCMAKE_C_FLAGS="${MPI_CFLAGS}  " \
       -DCMAKE_SHARED_LINKER_FLAGS="${MPI_LDFLAGS} -ldl " \
       -DCMAKE_EXE_LINKER_FLAGS="${MPI_LDFLAGS} -ldl " \
       -DQDP_PROP_OPT=OFF \
       -DGPU_TARGETS=${TARGET_GPU} \
       -DCMAKE_CXX_STANDARD=17 \
       -DCMAKE_CXX_EXTENSIONS=OFF \
       -DQDP_BUILD_EXAMPLES=OFF \
       -DHDF5_ROOT=${INSTALLROOT}/${HDF5} \
       -DQDP_USE_HDF5=${H5} \
       -DQDP_AC_ALIGNMENT_SIZE=128





cmake --build . -j 16 -v
cmake --install .

popd
