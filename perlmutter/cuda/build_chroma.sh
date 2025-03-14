source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_chroma ];
then
  rm -rf ./build_chroma
fi

mkdir  ./build_chroma
cd ./build_chroma
cmake ${SRCROOT}/chroma -DCMAKE_CXX_COMPILER=mpicxx \
		-DCMAKE_C_COMPILER=mpicc -DCMAKE_C_STANDARD=99 -DCMAKE_C_EXTENSIONS=OFF  \
	 	-DBUILD_SHARED_LIBS=ON \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo \
		-DQDPXX_DIR=${INSTALLROOT}/qdpxx/lib/cmake/QDPXX \
		-DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
	  	-DChroma_ENABLE_QUDA=ON \
		-DChroma_ENABLE_OPENMP=ON \
		-DQUDA_DIR=${INSTALLROOT}/quda/lib/cmake/QUDA \
		-DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/chroma

cmake --build . -j 32 
cmake --install .

popd
