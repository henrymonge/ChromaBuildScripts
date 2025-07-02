source ./env_kokkos.sh

PKG=$QMP

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

cmake ${SRCROOT}/${PKG} -DQMP_MPI=ON \
	-DCMAKE_BUILD_TYPE=RelWithDebInfo \
	-DCMAKE_C_COMPILER=${CC} \
	-DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${PKG}  \
    -DBUILD_SHARED_LIBS=ON \
	-DCMAKE_C_STANDARD=99 \
	-DCMAKE_C_EXTENSIONS=OFF

cmake --build . -j 8  -v
cmake --install .

if [ $? -eq 0 ]; then
    echo "successful installation"
    echo "${PKG} : ${COMMIT} ($(date))" > ${INSTALLROOT}/${PKG}/GIT_info.txt
else
    echo "failed installation"
fi

popd

