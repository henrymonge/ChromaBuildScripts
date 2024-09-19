source ./env.sh
pushd ${BUILDROOT}

if [ -d ./build_qdpxx ];
then
  rm -rf ./build_qdpxx
fi

mkdir  ./build_qdpxx
cd ./build_qdpxx
cmake ${SRCROOT}/qdp-jit -DQDP_PARALLEL_ARCH=parscalar \
       -DQDP_PRECISION=double \
       -DCMAKE_BUILD_TYPE=RelWithDebInfo \
       -DBUILD_SHARED_LIBS=ON \
       -DCMAKE_CXX_COMPILER=mpicxx -DCMAKE_CXX_EXTENSIONS=OFF \
       -DCMAKE_C_COMPILER=mpicc -DCMAKE_C_STANDARD=99 -DCMAKE_C_EXTENSIONS=OFF \
       -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/qdpxx \
       -DQMP_DIR=${INSTALLROOT}/qmp/lib/cmake/QMP \
       -DLLVM_DIR=${INSTALLROOT}/llvm-13/lib/cmake/llvm \
       -DQDP_ENABLE_BACKEND=CUDA \
       -DQDP_BUILD_EXAMPLES=OFF \
       -DQDP_ENABLE_LLVM14=OFF \
       -DQDP_ENABLE_COMM_SPLIT_DEVICEINIT=ON \
       -DQDP_PROP_OPT=ON


cmake --build . -j 4  -v
cmake --install .

popd
