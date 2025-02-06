source ./env.sh
pushd ${BUILDROOT}

cd ./build_lalibe

cmake --build . -j 32 -v
cmake --install .

popd
