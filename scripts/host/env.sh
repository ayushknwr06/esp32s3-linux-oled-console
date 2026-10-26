# source this file: source scripts/host/env.sh
export PATH=$HOME/oldgcc:$PATH
export CMAKE_POLICY_VERSION_MINIMUM=3.5
export O=$HOME/esp32-linux-build/build/build-buildroot-esp32s3_devkit_c1_8m
export K=$O/build/linux-xtensa-6.11-esp32-tag
XTENSA_GNU_CONFIG=$(find ~/esp32-linux-build -name esp32s3.so -path "*xtensa-dynconfig*" | head -1)
export XTENSA_GNU_CONFIG
echo "gcc: $(gcc --version | head -1)"
echo "XTENSA_GNU_CONFIG=$XTENSA_GNU_CONFIG"
