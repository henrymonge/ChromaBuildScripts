source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_chroma ];
then
  rm -rf ./build_chroma
fi

mkdir  ./build_chroma
cd ./build_chroma
cmake ${SRCROOT}/${CHROMA_SRC} -G "Ninja" -DCMAKE_CXX_COMPILER=${CXX} \
		-DCMAKE_C_COMPILER=${CC} -DCMAKE_C_STANDARD=99 -DCMAKE_C_EXTENSIONS=OFF  \
	 	-DBUILD_SHARED_LIBS=ON \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo \
		-DQDPXX_DIR=${INSTALLROOT}/${QDP}/lib/cmake/QDPXX \
		-DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP \
                -DCMAKE_CXX_FLAGS="-fpermissive" \
	  	-DChroma_ENABLE_QUDA=ON \
		-DChroma_ENABLE_OPENMP=ON \
		-DQUDA_DIR=${INSTALLROOT}/${QUDA}/lib/cmake/QUDA \
		-DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${CHROMA}

cmake --build . -j 32 
cmake --install .

popd
