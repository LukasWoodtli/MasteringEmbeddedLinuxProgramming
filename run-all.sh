#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd ${thisScriptDir}

./02_LearningAboutToolchains/run-all.sh
./03_AllAboutBootloaders/run-all.sh
