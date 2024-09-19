source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_qmp ];
then
  rm -rf ./build_qmp
fi

mkdir  ./build_qmp
cd ./build_qmp

cmake ${SRCROOT}/qmp -G Ninja -DQMP_MPI=ON \
	-DCMAKE_BUILD_TYPE=RelWithDebInfo \
	-DCMAKE_C_COMPILER=mpicc \
	-DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/qmp  \
  -DBUILD_SHARED_LIBS=ON \
	-DCMAKE_C_STANDARD=99 \
	-DCMAKE_C_EXTENSIONS=OFF

cmake --build . -j 8  -v
cmake --install .

popd

