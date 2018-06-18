#!/bin/bash

set -e
set -u


thisScriptDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker run -it --rm --privileged=true -v /etc/passwd:/etc/passwd:ro -v /etc/group:/etc/group:ro -u $UID:$(id -g) -v $(pwd):$thisScriptDir -w=$thisScriptDir lukaswoodtli/mastering_embedded_linux "$@"
