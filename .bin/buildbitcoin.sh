#!/bin/bash
set -eu

git clone http://git.localhost/bitcoin/bitcoin.git
cd bitcoin
wget http://git.localhost/minibolt-guide/minibolt/raw/branch/main/resources/ordisrespector.patch
git apply ordisrespector.patch
cmake -B build --install-prefix $PWD/out -DBUILD_TESTS=OFF -DWITH_ZMQ=ON
cmake --build build -j 6
cmake --install
