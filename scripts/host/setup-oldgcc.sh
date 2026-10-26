#!/usr/bin/env bash
# Make gcc and g++ point to version 13 inside ~/oldgcc (GCC 15 breaks the old sources).
set -e
sudo apt install -y gcc-13 g++-13
mkdir -p ~/oldgcc
ln -sf /usr/bin/gcc-13 ~/oldgcc/gcc
ln -sf /usr/bin/gcc-13 ~/oldgcc/cc
ln -sf /usr/bin/g++-13 ~/oldgcc/g++
ln -sf /usr/bin/g++-13 ~/oldgcc/c++
echo "Done. Now run: source scripts/host/env.sh"
