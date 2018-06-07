#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# for Fedora
#sudo dnf install autoconf gperf bison flex texinfo help2man gcc-c++ patch ncurses-devel python-devel perl-Thread-Queue git libtool


cd ${thisScriptDir}/crosstool-ng

./bootstrap
./configure --enable-local
make
make install

# add the configuration
cp -f ${thisScriptDir}/dot.config ${thisScriptDir}/crosstool-ng/.config
# build the toolchain
./ct-ng build.2
