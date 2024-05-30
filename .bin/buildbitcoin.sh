#!/bin/bash
set -eu

git clone http://localhost:2080/bitcoin/bitcoin.git
cd bitcoin
wget http://localhost:2080/minibolt-guide/minibolt/raw/branch/main/resources/ordisrespector.patch
git apply ordisrespector.patch
./autogen.sh
./configure --prefix=$PWD/out --disable-man --disable-tests --disable-bench --enable-reduce-exports --without-gui --enable-util-cli --disable-util-util --disable-upnp --without-natpmp --disable-fuzz --disable-fuzz-binary --disable-util-wallet --disable-util-tx --disable-man
make -j$(nproc)
make install
