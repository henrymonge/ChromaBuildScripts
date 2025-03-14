source ./env.sh
#
# Seemingly QDPXX finds an installed one so no need to build this
# ./build_libxml2.sh 

pushd ../src
./populate.sh
popd
 
./build_qmp.sh
./build_qdpxx.sh
./build_quda.sh
./build_chroma.sh
./build_glu.sh
