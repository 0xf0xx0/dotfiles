#!/bin/bash
set -eu

git clone http://git.localhost/bitcoin/bitcoin.git
cd bitcoin
wget http://git.localhost/minibolt-guide/minibolt/raw/branch/main/resources/ordisrespector.patch
git apply ordisrespector.patch
cmake -B build --install-prefix $PWD/out \
  -DBUILD_TESTS=OFF -DWITH_ZMQ=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_CXX_FLAGS_RELEASE="-O2 -g0"
cmake --build build -j 6
cmake --install build 
strip out/bin/*
