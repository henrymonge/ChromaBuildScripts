#!/bin/bash

pushd /lustre/orion/world-shared/stf006/mcamacho/hip_rocm_5_3_0
source ./env.sh
popd


srun -N 1 -n 8 ./install/quda/bin/su3_test --gridsize 1 2 2 2 --dim 16 16 16 96 --prec double
