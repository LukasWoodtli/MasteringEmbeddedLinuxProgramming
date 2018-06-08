#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${thisScriptDir}

./build_u_boot.sh
