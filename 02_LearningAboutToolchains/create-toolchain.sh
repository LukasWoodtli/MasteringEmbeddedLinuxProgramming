#!/bin/bash


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

