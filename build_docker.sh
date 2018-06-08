#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $thisScriptDir

docker build -t lukaswoodtli/mastering_embedded_linux .
