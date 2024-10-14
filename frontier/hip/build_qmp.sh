source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_qmp ];
then
  rm -rf ./build_qmp
fi

mkdir  ./build_qmp
cd ./build_qmp

cmake ${SRCROOT}/${QMP} -G Ninja -DQMP_MPI=ON \
	-DCMAKE_BUILD_TYPE=RelWithDebInfo \
	-DCMAKE_C_COMPILER=${CC} \
	-DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${QMP}  \
  -DBUILD_SHARED_LIBS=ON \
	-DCMAKE_C_STANDARD=99 \
	-DCMAKE_C_EXTENSIONS=OFF

cmake --build . -j 8  -v
cmake --install .

popd

