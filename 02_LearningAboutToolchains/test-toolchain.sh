#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${thisScriptDir}


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
# This is not set (but should be according to the book):
# grep -e "--with-arch=armv7-a" gcc-config.txt
grep -e "--with-cpu=cortex-a8" gcc-config.txt
# This is not set (but should be according to the book):
# grep -e "--with-tune=cortex-a8" gcc-config.txt
grep -e "--with-float=hard" gcc-config.txt
grep -e "--enable-threads=posix" gcc-config.txt


# sys root of the toolchain
sysRootDir=$(arm-cortex_a8-linux-gnueabihf-gcc -print-sysroot)

# dynamic linking

# a libc is linked automatically (e.g. libc.so.6)
arm-cortex_a8-linux-gnueabihf-readelf -a helloworld | grep "Shared library" | grep "libc.so"

# a interpreter is set (e.g /lib/ld-linux-armhf.so.3)
arm-cortex_a8-linux-gnueabihf-readelf -a helloworld | grep "program interpreter" | grep "/lib/ld-linux-armhf.so"


# static linking
arm-cortex_a8-linux-gnueabihf-gcc -static helloworld.c -o helloworld-static

# check that static linking results in bigger executable than dynamic linking
function executable_size {
    ls -l $1 | awk '{ print $5 }'
}

if [ `executable_size helloworld` -ge `executable_size helloworld-static` ]
then
    echo "Error static linked executable should be bigger than dynamic linked one"
    exit -1
fi

# create static library (archive)
arm-cortex_a8-linux-gnueabihf-gcc -c test1.c
arm-cortex_a8-linux-gnueabihf-gcc -c test2.c
arm-cortex_a8-linux-gnueabihf-ar rc libtest.a test1.o test2.o

# link to library
arm-cortex_a8-linux-gnueabihf-gcc helloworld-with-static-lib.c -ltest -L./ -o helloworld-with-static-lib
arm-cortex_a8-linux-gnueabihf-nm helloworld-with-static-lib | grep helloWorld1
arm-cortex_a8-linux-gnueabihf-nm helloworld-with-static-lib | grep helloWorld1

