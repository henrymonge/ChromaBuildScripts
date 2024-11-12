source ./env.sh

pushd ${SRCROOT}/${QDP_SRC}
COMMIT=`git rev-parse HEAD`
echo "${QDP_SRC} commit ${COMMIT}"
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
       -DCMAKE_C_FLAGS="${MPI_CFLAGS}" \
       -DCMAKE_SHARED_LINKER_FLAGS="${MPI_LDFLAGS}" \
       -DCMAKE_EXE_LINKER_FLAGS="${MPI_LDFLAGS}" \
	   -DQDP_PROP_OPT=OFF \
	   -DCMAKE_CXX_STANDARD=17 \
	   -DCMAKE_CXX_EXTENSIONS=OFF \
       -DQDP_BUILD_EXAMPLES=ON \
	   -DQDP_AC_ALIGNMENT_SIZE=128

cmake --build . -j 32  -v
cmake --install .

if [ $? -eq 0 ]; then
    echo "successful installation"
    echo "${QDP} : ${COMMIT} ($(date))" > ${INSTALLROOT}/${QDP}/GIT_info.txt
else
    echo "failed installation"
fi


popd

