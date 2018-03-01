#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${thisScriptDir}


# toolchain
export PATH=~/x-tools/arm-cortex_a8-linux-gnueabihf/bin/:$PATH
cd ${thisScriptDir}


rm -f sqlite-autoconf-3081101.tar.gz

# download sqlite
wget http://www.sqlite.org/2015/sqlite-autoconf-3081101.tar.gz
# unpack
tar xf sqlite-autoconf-3081101.tar.gz

pushd sqlite-autoconf-3081101

# configure
CC=arm-cortex_a8-linux-gnueabihf-gcc ./configure --host=arm-cortex_a8-linux-gnueabihf --prefix=/usr
# make install
make DESTDIR=$(arm-cortex_a8-linux-gnueabihf-gcc -print-sysroot) install

popd

# some checks
# executable
if [[ -x $(arm-cortex_a8-linux-gnueabihf-gcc -print-sysroot)/usr/bin/sqlite3 ]]
then
  echo ok
else
  echo fail
  exit -1
fi
# dynamic lib
if [[ -x $(arm-cortex_a8-linux-gnueabihf-gcc -print-sysroot)/usr/lib/libsqlite3.so.0.8.6 ]]
  then echo ok
else
  echo fail
  exit -1
fi
# header
if [[ -f $(arm-cortex_a8-linux-gnueabihf-gcc -print-sysroot)/usr/include/sqlite3.h ]]
  then echo ok
else
  echo fail
  exit -1
fi


# compile small example
rm -f sqlite-test

# get flags from pkg-config
compileFlags=$(PKG_CONFIG_LIBDIR=$(arm-cortex_a8-linux-gnueabihf-gcc -print-sysroot)/usr/lib/pkgconfig pkg-config sqlite3 --libs --cflags)

# build
arm-cortex_a8-linux-gnueabihf-gcc $compileFlags sqlite-test.c -o sqlite-test

# check if example was cross-compiled
file sqlite-test | grep "ARM"
