source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_qdpxx ];
then
  rm -rf ./build_qdpxx
fi

mkdir  ./build_qdpxx
cd ./build_qdpxx
cmake ${SRCROOT}/${QDP_SRC} -G "Ninja" -DQDP_PARALLEL_ARCH=parscalar \
       -DQDP_PRECISION=double \
       -DCMAKE_BUILD_TYPE=RelWithDebInfo \
       -DBUILD_SHARED_LIBS=ON \
       -DCMAKE_CXX_COMPILER=${CXX} -DCMAKE_CXX_EXTENSIONS=OFF \
       -DCMAKE_C_COMPILER=${CC} -DCMAKE_C_STANDARD=99 -DCMAKE_C_EXTENSIONS=OFF \
       -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${QDP} \
       -DHDF5_ROOT=${INSTALLROOT}/${HDF5} \
       -DQDP_USE_HDF5=${H5} \
       -DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP

cmake --build . -j 4  -v
cmake --install .

popd
