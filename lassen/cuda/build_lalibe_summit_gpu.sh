source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_lalibe ];
then
  rm -rf ./build_lalibe
fi

mkdir  ./build_lalibe
cd ./build_lalibe


cmake ${SRCROOT}/${LALIBE_SRC} -DBUILD_HDF5=${H5} -DCMAKE_CXX_COMPILER=${CXX} \
                   -DCMAKE_C_COMPILER=${CC} -DCMAKE_CXX_STANDARD=17 -DCMAKE_C_STANDARD=99 -DCMAKE_C_EXTENSIONS=OFF  \
                   -DCHROMA_INSTALL=${INSTALLROOT}/${CHROMA}/lib/cmake/Chroma \
                   -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${LALIBE} \
                   -DQUDA_DIR=${INSTALLROOT}/${QUDA}/lib/cmake/QUDA \
                   -DQDPXX_DIR=${INSTALLROOT}/${QDP}/lib/cmake/QDPXX \
                   -DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP \
                   -DCMAKE_CXX_FLAGS="-I${INSTALLROOT}/${HDF5}/include" \
                   -DCMAKE_BUILD=ON \
                   -DChroma_DIR=${INSTALLROOT}/${CHROMA}/lib/cmake/Chroma \
                   -DCHROMA_ROOT=${INSTALLROOT}/${CHROMA}/lib/cmake/Chroma

#       -DCMAKE_CXX_FLAGS="${MPI_CFLAGS}" \
#       -DCMAKE_C_FLAGS="${MPI_CFLAGS}" \
#       -DCMAKE_SHARED_LINKER_FLAGS="${MPI_LDFLAGS}" \
#       -DCMAKE_EXE_LINKER_FLAGS="${MPI_LDFLAGS}" \
 
cmake --build . -j 32 -v
cmake --install .

popd
