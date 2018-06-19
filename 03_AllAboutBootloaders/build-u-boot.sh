#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


export PATH=$thisScriptDir/../02_LearningAboutToolchains/x-tools/arm-cortex_a8-linux-gnueabihf/bin/:$PATH

cd ${thisScriptDir}/u-boot

# check if toolchain is available
arm-cortex_a8-linux-gnueabihf-gcc --version #> /dev/null


# build Das u-boot
make CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf- am335x_boneblack_defconfig
make CROSS_COMPILE=arm-cortex_a8-linux-gnueabihf-
