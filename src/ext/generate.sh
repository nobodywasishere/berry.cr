#!/usr/bin/env bash

set -e

cd $(dirname "$0")

git clone https://github.com/berry-lang/berry || echo

cd berry

make

ar rvs ../berry.a src/*.o
