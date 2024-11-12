source ./env.sh

pushd ${SRCROOT}/${QUDA_SRC}

COMMIT=`git rev-parse HEAD`
echo "${QUDA_SRC} commit ${COMMIT}"

popd

pushd ${BUILDROOT}

if [ -d ./build_${QUDA} ];
then
  rm -rf ./build_${QUDA}
fi

mkdir  ./build_${QUDA}
cd ./build_${QUDA}

#mkdir cmake
#cp ${TOPDIR_HIP}/CPM.cmake ./cmake/CPM_0.34.0.cmake

export QUDA_GPU_ARCH=${TARGET_GPU}

cmake ${SRCROOT}/${QUDA_SRC} \
        -G "Unix Makefiles" \
	    -DQUDA_TARGET_TYPE="HIP" \
		-DQUDA_GPU_ARCH=${TARGET_GPU} \
	    -DROCM_PATH=${ROCM_PATH} \
        -DQUDA_DIRAC_CLOVER=ON \
        -DQUDA_DIRAC_CLOVER_HASENBUSCH=OFF \
        -DQUDA_DIRAC_DOMAIN_WALL=OFF \
        -DQUDA_MDW_FUSED_LS_LIST="8" \
        -DQUDA_DIRAC_NDEG_TWISTED_MASS=OFF \
        -DQUDA_DIRAC_STAGGERED=OFF \
        -DQUDA_DIRAC_TWISTED_MASS=OFF \
        -DQUDA_DIRAC_TWISTED_CLOVER=OFF \
        -DQUDA_DIRAC_WILSON=ON \
        -DQUDA_DYNAMIC_CLOVER=OFF \
        -DQUDA_FORCE_GAUGE=ON \
        -DQUDA_FORCE_HISQ=ON \
        -DQUDA_GAUGE_ALG=ON \
        -DQUDA_GAUGE_TOOLS=OFF \
        -DQUDA_QDPJIT=OFF \
       	-DQDPXX_DIR=${INSTALLROOT}/${QDP}/lib/cmake/QDPXX \
        -DQUDA_INTERFACE_QDPJIT=OFF \
        -DQUDA_INTERFACE_MILC=OFF \
        -DQUDA_INTERFACE_CPS=OFF \
        -DQUDA_INTERFACE_QDP=ON \
        -DQUDA_INTERFACE_TIFR=OFF \
	    -DQUDA_QMP=ON \
	    -DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP \
        -DQUDA_QIO=OFF \
        -DQUDA_OPENMP=OFF \
        -DQUDA_MULTIGRID=ON \
        -DQUDA_MAX_MULTI_BLAS_N=9 \
        -DQUDA_DOWNLOAD_EIGEN=ON \
        -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${QUDA} \
        -DCMAKE_BUILD_TYPE="DEVEL" \
        -DCMAKE_CXX_COMPILER=${CXX} \
        -DCMAKE_C_COMPILER=${CC} \
        -DBUILD_SHARED_LIBS=ON \
        -DQUDA_BUILD_SHAREDLIB=ON \
        -DQUDA_BUILD_ALL_TESTS=OFF \
        -DQUDA_CTEST_DISABLE_BENCHMARKS=ON \
	    -DCMAKE_CXX_FLAGS="${MPI_CFLAGS}" \
	    -DCMAKE_C_FLAGS="${MPI_CFLAGS}" \
	    -DCMAKE_EXE_LINKER_FLAGS="${MPI_LDFLAGS}" \
	    -DCMAKE_SHARED_LINKER_FLAGS="${MPI_LDFLAGS}" \
        -DCMAKE_C_STANDARD=99 

cmake --build . -j 32  -v
cmake --install .

if [ $? -eq 0 ]; then
    echo "successful installation"
    echo "${QUDA} : ${COMMIT} ($(date))" > ${INSTALLROOT}/${QUDA}/GIT_info.txt
else
    echo "failed installation"
fi

popd
