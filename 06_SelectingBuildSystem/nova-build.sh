#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${thisScriptDir}/poky

# create nova layer with: `scripts/yocto-layer create nova`

rm -rf "$thisScriptDir/poky/meta-nova"
cp -rf "$thisScriptDir/meta-nova-template" "$thisScriptDir/poky/meta-nova"

 rm -rf build-nova
# source build environment for given folder
set +u
source oe-init-build-env build-nova
set -u

cp -f "$thisScriptDir/nova-local.conf" "$thisScriptDir/poky/build-nova/conf/local.conf"


bitbake-layers add-layer ../meta-nova

bitbake-layers show-layers

# build
bitbake helloworld
