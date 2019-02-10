#!/bin/bash

set -e
set -u

# The code in this directory is not tested

thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


export PATH=$thisScriptDir/../02_LearningAboutToolchains/x-tools/arm-cortex_a8-linux-gnueabihf/bin/:$PATH

cd ${thisScriptDir}/

# check if toolchain is available
arm-cortex_a8-linux-gnueabihf-gcc --version #> /dev/null

make

