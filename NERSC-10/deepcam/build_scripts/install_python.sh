#!/bin/bash

if [[ -z "${N10_DEEPCAM}" ]]; then
  echo "The N10_DEEPCAM environment variable should be set before running  install_python.sh"
  exit 1 
fi

cd ${N10_DEEPCAM}
if [[ ! -d local/build ]]; then
    mkdir -p local/build
fi
cd local/build

#Python >= 3.9 is needed
#Python 3.9.16 is demonstrated below
#To use a different version, update the version and version_md5sum variables
#according to match https://www.python.org/downloads/source/
#
version=3.9.16
version_md5sum=38c99c7313f416dcf3238f5cf444c6c2

download_md5sum=`md5sum Python-$version.tgz|awk '{print $1}'`
if [[ $download_md5sum != $version_md5sum ]]; then
    rm -f Python-$version.tgz
    wget https://www.python.org/ftp/python/$version/Python-$version.tgz
fi
    
download_md5sum=`md5sum Python-$version.tgz|awk '{print $1}'`
if [[ $download_md5sum != $version_md5sum ]]; then
    echo "md5sum mismatch for Python-$version"
    echo "Expected:" $version_md5sum
    echo "Found:   " $download_md5sum    
    echo "Aborting Python-$version installation..."
    rm Python-$version.tgz
    exit 1 
fi

rm -f Python-$version

tar -xzf Python-$version.tgz

cd Python-$version

./configure \
    --enable-optimizations \
    --with-ensurepip=install \
    --prefix=${N10_DEEPCAM}/local

make -j16

make install

cd ${N10_DEEPCAM}/local/bin
ln -s python3 python
