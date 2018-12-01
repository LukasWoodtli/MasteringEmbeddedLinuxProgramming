#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${thisScriptDir}/poky

# source build environment for given folder
set +u
source oe-init-build-env build-quemuarm
set -u

cp -f "$thisScriptDir/qemuarm-local.conf" "$thisScriptDir/poky/build-quemuarm/conf/local.conf"

# build
bitbake core-image-minimal

# run it with (might not work in docker container):
# runqemu qemuarm nographic # end it with ctrl + a x
