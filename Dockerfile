FROM ubuntu:14.04

MAINTAINER Lukas Woodtli "http://lukaswoodtli.github.io/"

RUN apt-get update && \
	apt-get install -y --force-yes \
	automake \
	bison \
	chrpath \
	flex \
	gawk \
	git \
	gperf \
	g++ \
	help2man \
	libexpat1-dev \
	libncurses5-dev \
	libsdl1.2-dev \
	libtool \
	make \
	texinfo \
	unzip \
	wget \
	xz-utils

RUN apt-get clean

ENTRYPOINT ["/bin/bash", "-l"]
