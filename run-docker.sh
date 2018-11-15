#!/bin/bash

set -e
set -u

thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# get container from docker hub (docker.io)
#dockerContainer="docker.io/lukaswoodtli/masteringembeddedlinuxprogramming"

# use locally built container (using build-docker.sh)
dockerContainer="lukaswoodtli/mastering_embedded_linux"

docker run -it --rm -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -u $(id -u):$(id -g) -v $(pwd):$thisScriptDir -w=$thisScriptDir $dockerContainer "$@"
