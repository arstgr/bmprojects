#!/bin/bash
#set -x
set -e

if [[ -z "${N10_DEEPCAM}" ]]; then
  echo "The N10_DEEPCAM environment variable should be set before running  install_hdf5.sh"
  exit 1 
fi
source ${N10_DEEPCAM}/deepcam_env.sh
#deepcam_env.sh defines two envs: PREFIX and BUILD

cd ${BUILD}

version=1.12.2
major_version=${version%.*}

echo "Fetching HDF5..."
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-${major_version}/hdf5-${version}/src/hdf5-${version}.tar.gz

echo "Building HDF5..."
if [[ -d hdf5-${version} ]]; then 
    rm -rf ${hdf5_dir}
fi

tar xzf hdf5-${version}.tar.gz 
cd hdf5-${version} 

./configure --prefix=${PREFIX} 

make -j 16 
make install

