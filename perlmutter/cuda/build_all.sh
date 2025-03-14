source ./env.sh
#
# Seemingly QDPXX finds an installed one so no need to build this
# ./build_libxml2.sh 

<< 'COMMENT'
You may need to run this on a compute node.
You can get an interactive allocation on perlmutter with
salloc --nodes 1 --qos interactive --time 02:00:00 --constraint gpu --gpus 0 --account mxxxx
COMMENT

pushd ../src
./populate.sh
popd
 
./build_qmp.sh
./build_qdpxx.sh
./build_quda.sh
./build_chroma.sh
./build_glu.sh
