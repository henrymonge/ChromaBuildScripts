source ./env.sh
pushd ${BUILDROOT}

if [ -d ./${HDF5} ];
then
  rm -rf ./${HDF5}
fi

mkdir  ./${HDF5}
cd ./${HDF5}

cmake ${SRCROOT}/${HDF5} -G "Unix Makefiles"        -DCMAKE_CXX_COMPILER=${CXX} \
       -DCMAKE_C_COMPILER=${CC}  \
       -DCMAKE_BUILD_TYPE:STRING=Release \
       -DBUILD_SHARED_LIBS:BOOL=OFF \
       -DBUILD_TESTING:BOOL=ON \
       -DHDF5_BUILD_TOOLS:BOOL=ON \
       -DCMAKE_CXX_FLAGS="${MPI_CFLAGS} -I${INSTALLROOT}/${HDF5}/include " \
       -DCMAKE_C_FLAGS="${MPI_CFLAGS}  -I${INSTALLROOT}/${HDF5}/include " \
       -DCMAKE_SHARED_LINKER_FLAGS="${MPI_LDFLAGS}" \
       -DCMAKE_EXE_LINKER_FLAGS="${MPI_LDFLAGS}" \
       -DHDF5_ENABLE_PARALLEL:BOOL=ON \
       -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${HDF5} \
        ../hdf5-1.10."9"

cmake --build . -j 32 -v
cmake --install .

popd
