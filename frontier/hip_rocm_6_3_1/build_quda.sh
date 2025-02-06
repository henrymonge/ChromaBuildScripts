source ./env.sh

PKG=${QUDA}
PKG_SRC=${QUDA_SRC}

pushd ${SRCROOT}/${PKG}
COMMIT=`git rev-parse HEAD`
echo "${PKG} commit ${COMMIT}"
popd

pushd ${SRCROOT}/${PKG}

if [[ ! -d $SRCROOT ]]; then
    mkdir $SRCROOT
fi

if [[ ! -d $SRCROOT/${PKG} ]]; then
    pushd $SRCROOT
    git clone -b develop https://github.com/lattice/quda.git
    popd
fi

if [[ ! -d $BUILDROOT ]]; then
    mkdir $BUILDROOT
fi

pushd ${BUILDROOT}

if [ -d ./build_${PKG} ];
then
  rm -rf ./build_${PKG}
fi

mkdir  ./build_${PKG}
cd ./build_${PKG}

export QUDA_GPU_ARCH=${TARGET_GPU}

cmake ${SRCROOT}/${PKG_SRC} \
        -G "Unix Makefiles" \
	      -DQUDA_TARGET_TYPE="HIP" \
			  -DQUDA_GPU_ARCH=${TARGET_GPU} \
	      -DROCM_PATH=${ROCM_PATH} \
        -DQUDA_DIRAC_CLOVER=ON \
        -DQUDA_DIRAC_CLOVER_HASENBUSCH=OFF \
        -DQUDA_DIRAC_DOMAIN_WALL=ON \
        -DQUDA_MDW_FUSED_LS_LIST="8,12,16,20" \
        -DQUDA_DIRAC_NDEG_TWISTED_MASS=OFF \
        -DQUDA_DIRAC_STAGGERED=OFF \
        -DQUDA_LAPLACE=OFF \
        -DQUDA_DIRAC_TWISTED_MASS=OFF \
        -DQUDA_DIRAC_TWISTED_CLOVER=OFF \
        -DQUDA_DIRAC_WILSON=ON \
        -DQUDA_DYNAMIC_CLOVER=OFF \
        -DQUDA_FORCE_GAUGE=ON \
        -DQUDA_FORCE_HISQ=ON \
        -DQUDA_GAUGE_ALG=ON \
        -DQUDA_GAUGE_TOOLS=OFF \
        -DQUDA_QDPJIT=OFF \
        -DQUDA_INTERFACE_QDPJIT=OFF \
        -DQDPXX_DIR=${INSTALLROOT}/${QDP}/lib/cmake/QDPXX \
        -DQUDA_INTERFACE_MILC=ON \
        -DQUDA_INTERFACE_CPS=OFF \
        -DQUDA_INTERFACE_QDP=ON \
        -DQUDA_INTERFACE_TIFR=OFF \
        -DQUDA_MPI=OFF \
	    -DQUDA_QMP=ON \
          -DQMP_DIR=${INSTALLROOT}/${QMP}/lib/cmake/QMP \
        -DQUDA_QIO=OFF \
        -DQUDA_OPENMP=ON \
        -DQUDA_MULTIGRID=ON \
        -DQUDA_MAX_MULTI_BLAS_N=9 \
        -DQUDA_DOWNLOAD_EIGEN=ON \
        -DCMAKE_INSTALL_PREFIX=${INSTALLROOT}/${PKG} \
        -DCMAKE_BUILD_TYPE="RELEASE" \
        -DCMAKE_CXX_COMPILER=${CXX} \
        -DCMAKE_C_COMPILER=${CC} \
        -DBUILD_SHARED_LIBS=ON \
        -DQUDA_BUILD_SHAREDLIB=ON \
        -DQUDA_BUILD_ALL_TESTS=ON \
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
    echo "${PKG} : ${COMMIT} ($(date))" > ${INSTALLROOT}/${PKG}/GIT_info.txt
else
    echo "failed installation"
fi

popd
