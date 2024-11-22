#!/bin/bash

source ./env.sh

./install/quda/bin/staggered_gsmear_test --dslash-type laplace --laplace3D 3 --prec double --test Mat --dim 16 16 16 96

