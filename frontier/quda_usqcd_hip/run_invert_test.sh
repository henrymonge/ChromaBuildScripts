#!/bin/bash

source ./env.sh

./install/quda/bin/invert_test --prec double --dim 16 16 16 96

