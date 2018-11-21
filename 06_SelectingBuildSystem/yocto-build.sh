#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${thisScriptDir}/poky

# source build environment for given folder
set +u
source oe-init-build-env build-quemuarm
set -u


# build
bitbake core-image-minimal

