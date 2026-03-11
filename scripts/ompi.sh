#!/usr/bin/bash
set -e

ROOT=${ROOT:-$(git rev-parse --show-toplevel)}
BUILD_FILES="/tmp/$(whoami)"

mkdir -p "$BUILD_FILES"
pushd "$BUILD_FILES" || exit
OMPI_VERSION=5.0
OMPI_PATCH=10
OMPI_EXT=tar.bz2
OMPI_ARCHIVE="openmpi-${OMPI_VERSION}.${OMPI_PATCH}.${OMPI_EXT}"
wget -c "https://download.open-mpi.org/release/open-mpi/v${OMPI_VERSION}/${OMPI_ARCHIVE}"

rm -rf "${OMPI_ARCHIVE%.$OMPI_EXT}"
tar xvf ${OMPI_ARCHIVE}
pushd "${OMPI_ARCHIVE%.$OMPI_EXT}" || exit

export CC=clang
export CXX=clang++
export FC=flang

./configure --prefix="${ROOT}/opt"

make -j
make install

popd || exit
popd || exit
