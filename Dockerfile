#-------------------------------------------------------------------------------
# Dockerfile for cross-compilation of Ethereum C++ components for mobile
# Linux platforms such as Tizen, Sailfish and Ubuntu Touch.
#
# See http://ethereum.org/ to learn more about Ethereum.
# See http://doublethink.co/ to learn more about doublethinkco
#
# boot2docker on Mac does not "just work" when installed.  Here are the
# commands you will inevitably forget whenever you reboot or start a new
# terminal session:
# http://stackoverflow.com/questions/29594800/docker-tls-error-on-mac/
#
# (c) 2015 Kitsilano Software Inc
#-------------------------------------------------------------------------------

FROM ubuntu:14.04
MAINTAINER Bob Summerwill <bob@summerwill.net>

RUN apt-get update
RUN apt-get install -y wget git

# install docker
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
RUN echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
RUN cat /etc/apt/sources.list.d/docker.list
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get purge lxc-docker*
RUN apt-cache policy docker-engine # quick check
RUN apt-get install -y docker-engine
RUN apt-get install -y -q linux-image-extra-$(uname -r) 
RUN service docker start
RUN docker run hello-world # quick check

# add user
RUN useradd -ms /bin/bash xcompiler
USER xcompiler
WORKDIR     /home/xcompiler

# install go
RUN wget https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz
RUN tar -zxf go1.5.1.linux-amd64.tar.gz
WORKDIR     /home/xcompiler/go/bin

# install xgo
RUN mkdir   /home/xcompiler/xgo
ENV GOPATH="/home/xcompiler/xgo"
ENV GOROOT="/home/xcompiler/go"
RUN ./go get github.com/karalabe/xgo

# run xgo
WORKDIR     /home/xcompiler/xgo/bin

RUN ./xgo \
    --deps=https://gmplib.org/download/gmp/gmp-6.0.0a.tar.bz2 \
    --branch=develop \
  github.com/ethereum/go-ethereum/cmd/geth
RUN ls      /home/xcompiler/xgo/bin
