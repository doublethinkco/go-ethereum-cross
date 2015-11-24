#!/bin/bash
# to be run from an ubuntu machine with wget, git, go (golang) and docker installed (https://docs.docker.com/v1.8/installation/ubuntulinux/)
# author: Anthony Cros (cros.anthony@gmail.com)

# ===========================================================================
set -e

# ===========================================================================
# args:
WD=$1 # can pass in a work directory
WD=${WD:="$HOME/geth"} # else defaults to this valu

# ===========================================================================
# sanity checks:
hash wget git go # quick check that wget and git are present
docker run hello-world # check docker is installed
touch /tmp/xgo-cache/dummy || { echo "ERROR: '$USER' is not allowed to '/tmp/xgo-cache'"; exit 1; } # check have write access to /tmp/xgo-cache
rm    /tmp/xgo-cache/dummy

# ===========================================================================
mkdir -p ${WD?}
cd ${WD?}

# ---------------------------------------------------------------------------
# install go:
wget -O- https://storage.googleapis.com/golang/go1.5.1.linux-amd64.tar.gz | tar zx
export GOROOT="${WD?}/go"

# ---------------------------------------------------------------------------
# install xgo:
mkdir -p ${WD?}/xgo
export GOPATH="${WD?}/xgo"
cd ${WD?}/go/bin
./go get github.com/karalabe/xgo

# ---------------------------------------------------------------------------
# run xgo:
cd ${WD?}/xgo/bin
./xgo \
    --deps=https://gmplib.org/download/gmp/gmp-6.0.0a.tar.bz2 \
    --branch=develop \
  github.com/ethereum/go-ethereum/cmd/geth

# ===========================================================================
# check result:

ls ${WD?}/geth/xgo/bin/geth-linux-arm

# ===========================================================================
