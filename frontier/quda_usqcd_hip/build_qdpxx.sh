source ./env.sh

PKG=${QDP}

pushd ${SRCROOT}/${PKG}
COMMIT=`git rev-parse HEAD`
echo "${PKG} commit ${COMMIT}"
popd

pushd ${BUILDROOT}

if [ -d ./build_${PKG} ];
then
  rm -rf ./build_${PKG}
fi

mkdir  ./build_${PKG}
cd ./build_${PKG}

cmake ${SRCROOT}/${PKG} -DQDP_PARALLEL_ARCH=parscalar \
       -DQDP_PRECISION=double \
       -DCMAKE_BUILD_TYPE=${PK_BUILD_TYPE} \
       -DBUILD_SHARED_LIBS=ON \
       -DCMAKE_CXX_COMPILER=${CXX} \
       -DCMAKE_C_COMPILER=${CC}  \
       -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${PKG} \
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
       -DQDP_AC_ALIGNMENT_SIZE=128


cmake --build . -j 16 -v
cmake --install .

if [ $? -eq 0 ]; then
    echo "successful installation"
    echo "${PKG} : ${COMMIT} ($(date))" > ${INSTALLROOT}/${PKG}/GIT_info.txt
else
    echo "failed installation"
fi

popd
