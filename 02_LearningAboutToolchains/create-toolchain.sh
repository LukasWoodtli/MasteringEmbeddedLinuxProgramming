#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${thisScriptDir}/crosstool-ng

./bootstrap
./configure --enable-local
make
make install


# Beaglebone Black
# add the configuration
#cp -f ${thisScriptDir}/dot.config ${thisScriptDir}/crosstool-ng/.config
# build the toolchain
#./ct-ng build.2


# QEMU
./ct-ng distclean
cp -f ${thisScriptDir}/dot.config.qemu ${thisScriptDir}/crosstool-ng/.config
# build the toolchain
./ct-ng build.2

