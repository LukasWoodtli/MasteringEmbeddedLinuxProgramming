#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# for Fedora
#sudo dnf install autoconf gperf bison flex texinfo help2man gcc-c++ patch ncurses-devel python-devel perl-Thread-Queue git libtool


cd ${thisScriptDir}

git clone https://github.com/crosstool-ng/crosstool-ng crosstool-ng


cd crosstool-ng

./bootstrap
./configure --enable-local
make
make install

# add the configuration
cp -f ${thisScriptDir}/dot.config ${thisScriptDir}/crosstool-ng/.config
# build the toolchain
./ct-ng build


# test
export PATH=~/x-tools/arm-cortex_a8-linux-gnueabihf/bin/:$PATH
cd ${thisScriptDir}

# build example
arm-cortex_a8-linux-gnueabihf-gcc helloworld.c -o helloworld

# check if crosscompiled for ARM
file helloworld | grep ARM

# check configuration of cross-toolchain
arm-cortex_a8-linux-gnueabihf-gcc -v &> gcc-config.txt
grep -e "--with-sysroot=/home/$USER/x-tools/arm-cortex_a8-linux-gnueabihf/arm-cortex_a8-linux-gnueabihf/sysroot" gcc-config.txt
grep -e "--enable-languages=c,c++" gcc-config.txt
grep -e "--with-arch=armv7-a" gcc-config.txt
grep -e "--with-cpu=cortex-a8" gcc-config.txt
grep -e "--with-tune=cortex-a8" gcc-config.txt
grep -e "--with-float=hard" gcc-config.txt
grep -e "--enable-threads=posix" gcc-config.txt

