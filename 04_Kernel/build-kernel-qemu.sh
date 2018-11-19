#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${thisScriptDir}
cd ${thisScriptDir}/linux-stable

# Build Kernel for qemu
export PATH=$thisScriptDir/../02_LearningAboutToolchains/x-tools/arm-unknown-linux-gnueabi/bin/:$PATH

make ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnueabi- mrproper
make ARCH=arm versatile_defconfig
make -j4 ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnueabi- zImage
make -j4 ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnueabi- modules
make ARCH=arm CROSS_COMPILE=arm-unknown-linux-gnueabi- dtbs
