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
#git clone --recursive https://github.com/pytorch/pytorch
git clone --recursive https://github.com/amd/ZenDNN-pytorch
#cd pytorch
cd ZenDNN-pytorch
git submodule sync
git submodule update --init --recursive
#git checkout v2.0.0  #compilation error with torch/csrc/profiler/kineto_client_interface.cpp
#git checkout b32afbb

source ~/.bashrc
source /mnt/resource_nvme/hpcx*/hpcx-init.sh
hpcx_load
source /apps/aocl/4.1.0/gcc/amd-libs.cfg

glog_prefix=$N10_DEEPCAM/local
export USE_ROCM=0
export USE_CUDNN=0
export USE_CUSPARSELT=0
#export USE_MKLDNN=0
#export USE_FBGEMM=0
export USE_DISTRIBUTED=1
export USE_MPI=1
export USE_OPENMP=1
export NO_CUDA=1
export USE_CUDA=0
export NO_CUDNN=1
export USE_GLOO=1
export USE_ZENDNN=1
export CC=mpicc
export CXX=mpic++
export CFLAGS="-I$glog_prefix/include -march=znver4 -O3"
export CXXFLAGS=$CFLAGS
export LD_LIBRARY_PATH=$glog_prefix/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=$glog_prefix/lib64:$LD_LIBRARY_PATH

python3 setup.py install

