FROM ubuntu:14.04

MAINTAINER Lukas Woodtli "http://lukaswoodtli.github.io/"

RUN apt-get update
RUN apt-get install -y --force-yes automake bison chrpath flex g++ git gperf gawk libexpat1-dev libncurses5-dev libsdl1.2-dev texinfo wget make libtool xz-utils help2man
RUN apt-get clean

ENTRYPOINT ["/bin/bash", "-l"]
