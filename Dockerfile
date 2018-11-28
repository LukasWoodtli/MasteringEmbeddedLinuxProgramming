FROM ubuntu:14.04

MAINTAINER Lukas Woodtli "http://lukaswoodtli.github.io/"

RUN apt-get update && \
	apt-get install -y --force-yes \
	automake \
	bc \
	bison \
	chrpath \
	diffstat \
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
	locales \
	make \
	texinfo \
	uml-utilities \
	unzip \
	wget \
	xz-utils

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

ENTRYPOINT ["/bin/bash", "-l"]

