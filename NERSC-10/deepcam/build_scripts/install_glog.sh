#!/bin/bash
#set -x
set -e

if [[ -z "${N10_DEEPCAM}" ]]; then
  echo "The N10_DEEPCAM environment variable should be set before running  install_glog.sh"
  exit 1 
fi
source ${N10_DEEPCAM}/deepcam_env.sh
#deepcam_env.sh defines two envs: PREFIX and BUILD

cd ${BUILD}

echo "Fetching glog..."
wget https://github.com/google/glog/archive/refs/tags/v0.6.0.tar.gz
tar xvzf v0.6.0.tar.gz
cd glog-0.6.0

echo "Building glog..."
cmake -S . -B build -G "Unix Makefiles"
cmake --build build -j16
cmake --install build --prefix ${PREFIX}




