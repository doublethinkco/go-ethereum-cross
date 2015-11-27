#-------------------------------------------------------------------------------
# Dockerfile for cross-compilation of Ethereum go client (geth), shamelessly
# copied from file shared by Péter Szilágyi <peterke@gmail.com> on Ethereum
# porting channel.
#
# See http://ethereum.org/ to learn more about Ethereum.
# See http://doublethink.co/ to learn more about doublethinkco
#
# (c) 2015 Kitsilano Software Inc
#-------------------------------------------------------------------------------

FROM karalabe/xgo-1.5.1
MAINTAINER Bob Summerwill <bob@summerwill.net>

ENV IMPORT_PATH github.com/ethereum/go-ethereum

RUN \
  echo "Pulling Go Ethereum repository..."                && \
  git clone https://$IMPORT_PATH $GOPATH/src/$IMPORT_PATH && \
  \
  echo "Preparing for cross compilation..." && \
  cd $GOPATH/src/$IMPORT_PATH               && \
  mkdir ./build/bin                         && \
  ln -s `readlink -f ./build/bin` /build    && \
  \
  echo "Cross compiling Go Ethereum" && \
  make geth-linux-arm GO=1.5-develop
