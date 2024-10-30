source ./env.sh

pushd ${SRCROOT}/${QMP}

COMMIT=`git rev-parse --short HEAD`
echo "${QMP} commit ${COMMIT}"

popd


pushd ${BUILDROOT}

if [ -d ./build_${QMP} ];
then
  rm -rf ./build_${QMP}
fi

mkdir  ./build_${QMP}
cd ./build_${QMP}

cmake ${SRCROOT}/${QMP} -DQMP_MPI=ON \
	-DCMAKE_BUILD_TYPE=${PK_BUILD_TYPE} \
	-DCMAKE_C_COMPILER=${CC} \
	-DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${QMP}  \
	-DCMAKE_C_FLAGS="${MPI_CFLAGS}" \
	-DCMAKE_EXE_LINKER_FLAGS="${MPI_LDFLAGS}" \
	-DCMAKE_SHARED_LINKER_FLAGS="${MPI_LDFLAGS}" \
  -DBUILD_SHARED_LIBS=ON \
	-DCMAKE_C_STANDARD=99 \
	-DCMAKE_C_EXTENSIONS=OFF

cmake --build . -j 32  -v
cmake --install .

popd

