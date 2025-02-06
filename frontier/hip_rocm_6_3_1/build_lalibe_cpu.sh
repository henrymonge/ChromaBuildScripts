source ./env_cpu.sh
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
                   -DQDPXX_DIR=${INSTALLROOT}/${QDP}/lib/cmake/QDPXX \
                   -DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP \
                   -DCMAKE_CXX_FLAGS="-DH5_USE_18_API -fopenmp" \
                   -DCMAKE_C_FLAGS="-fopenmp" \
                   -DCMAKE_BUILD=ON \
                   -DHDF5_ROOT=${INSTALLROOT}/${HDF5} \
                   -DChroma_DIR=${INSTALLROOT}/${CHROMA}/lib/cmake/Chroma \
                   -DCHROMA_ROOT=${INSTALLROOT}/${CHROMA}/lib/cmake/Chroma

cmake --build . -j 32 -v
cmake --install .

popd
