source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_qdpxx ];
then
  rm -rf ./build_qdpxx
fi

mkdir  ./build_qdpxx
cd ./build_qdpxx


cmake ${SRCROOT}/qdpxx -DQDP_PARALLEL_ARCH=parscalar \
       -DQDP_PRECISION=double \
       -DCMAKE_BUILD_TYPE=${PK_BUILD_TYPE} \
       -DBUILD_SHARED_LIBS=ON \
       -DCMAKE_CXX_COMPILER=${CXX} \
       -DCMAKE_C_COMPILER=${CC}  \
       -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/qdpxx \
       -DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP \
       -DCMAKE_CXX_FLAGS=" -O3 -DH5_USE_18_API " \
       -DCMAKE_C_FLAGS=" -O3 " \
       -DCMAKE_SHARED_LINKER_FLAGS=" -ldl " \
       -DCMAKE_EXE_LINKER_FLAGS=" -ldl " \
       -DQDP_PROP_OPT=OFF \
       -DGPU_TARGETS=${TARGET_GPU} \
       -DCMAKE_CXX_STANDARD=17 \
       -DCMAKE_CXX_EXTENSIONS=OFF \
       -DQDP_BUILD_EXAMPLES=OFF \
       -DQDP_USE_HDF5=ON \
       -DHDF5_ROOT=${HDF5_ROOT} \
       -DQDP_AC_ALIGNMENT_SIZE=128


cmake --build . -j 4  -v
cmake --install .

popd
