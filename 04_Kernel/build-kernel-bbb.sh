#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${thisScriptDir}

# Build kernel for BeagleBone Black
export PATH=$thisScriptDir/../02_LearningAboutToolchains/x-tools/arm-cortex_a8-linux-gnueabihf/bin/:$PATH

cd ${thisScriptDir}/linux-stable

make ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- mrproper
make ARCH=arm multi_v7_defconfig
make -j4 ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- zImage
make -j4 ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- modules
make ARCH=arm CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- dtbs
