#!/bin/bash
#install pytorch from source to enable MPI

set -e

if [[ -z "${N10_DEEPCAM}" ]]; then
  echo "The N10_DEEPCAM environment variable should be set before running  install_pytorch_pm.sh"
  exit 1
fi

source ${N10_DEEPCAM}/deepcam_env.sh
#deepcam_env.sh defines two envs: PREFIX and BUILD
cd $BUILD
git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
#rm -rf build/*
#git checkout v2.0.0  #compilation error with torch/csrc/profiler/kineto_client_interface.cpp
#git checkout b32afbb

module load mpi/hpcx
export OMPI_CC=clang
export OMPI_CXX=clang++
export OMPI_FC=flang
export ORTE_CC=clang
export ORTE_CXX=clang++
export OPAL_CC=clang
export OPAL_CXX=clang++

export OMPI_CXXFLAGS="-O3 -Ofast -fopenmp"
export OMPI_CFLAGS="-O3 -Ofast -fopenmp"

export TMPDIR=${N10_DEEPCAM}/tmp
export TMP=${N10_DEEPCAM}/tmp
export TEMP=${N10_DEEPCAM}/tmp

glog_prefix=$N10_DEEPCAM/local
export USE_ROCM=0
export USE_CUDNN=1
export USE_MKLDNN=0
export USE_FBGEMM=0
export USE_DISTRIBUTED=1
export USE_MPI=1
export USE_OPENMP=1
export MAX_JOBS=64
export CC=clang
export CXX=clang++
export CFLAGS="-I$glog_prefix/include -O3 -Ofast -fopenmp"
export CXXFLAGS=$CFLAGS
export LD_LIBRARY_PATH="$glog_prefix/lib:$LD_LIBRARY_PATH"
export LIBRARY_PATH="$glog_prefix/lib:$LD_LIBRARY_PATH"
#export PATH="$glog_prefix/bin:$PATH"

python3 setup.py clean
python3 setup.py install
