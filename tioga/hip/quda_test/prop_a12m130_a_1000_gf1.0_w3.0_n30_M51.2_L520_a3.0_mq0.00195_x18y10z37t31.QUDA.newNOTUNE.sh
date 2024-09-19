#!/usr/bin/env bash

#BSUB -nnodes 2
#BSUB -cn_cu 'maxcus=1'
#BSUB -q pbatch
#BSUB -G latticgc
#BSUB -W 120
#BSUB -core_isolation 2
#BSUB -alloc_flags smt4
#BSUB -alloc_flags atsdisable


source ../env.sh

export OMP_NUM_THREADS=4
PROG="$LALIBE_GPU  -geom 1 1 1 16"
export QUDA_ENABLE_TUNING=0

PROG=$BUILDROOT/build_quda/tests/invert_test

dim_grid="--dim 48 48 16 16 --gridsize 1 1 3 4"
m5="1.2"
L5="20"
b5="2.00"
c5="1.00"
mq="0.00195"

####MODIFY NEXT SECOND LINE#######
#ens=$/p/gpfs1/walkloud/c51/x_files/project_2/production/a12m130_a/cfgs_flow/l4864f211b600m00184m0507m628a.1000_wflow1.0.lime
ens=$PATH_TO_ENSEMBLE/l4864f211b600m00184m0507m628a.1000_wflow1.0.lime


ARGS="--dslash-type mobius $dim_grid \
      --Lsdim $L5 --m5 -$m5 --b5 $b5 --c5 $c5 --mass $mq \
      --load-gauge $ens \
      --verbosity verbose \
      --prec double --niter 14000 --prec-sloppy half --reliable-delta 0.1 --tol 1e-7\
      --solution-type mat --matpc odd-odd-asym "

stdout=prop_a12m130_a_1000_gf1.0_w3.0_n30_M51.2_L520_a3.0_x18y10z37t31.quda.new.stdout-noTUNE

echo "START  "$(date "+%Y-%m-%dT%H:%M")

#####MODIFY FOR YOUR SYSTEM#####
#jsrun --nrs 2 -r1 -a4 -g4 -c4 -l gpu-cpu -b packed:smt:4 $PROG $ARGS > $stdout 2>&1  --this line is for lassen--
srun -n 16 -N 2 --unbuffered --ntasks-per-node=8 --cpus-per-task=1 $PROG $ARGS > $stdout 2>&1 #This is what would work on frontier

echo "FINISH JOB "$(date "+%Y-%m-%dT%H:%M")
