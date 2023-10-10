#!/usr/bin/env bash

set -e

cd $(dirname "$0")

git clone https://github.com/berry-lang/berry || echo

cd berry

rm default/*

cp ../default/* default

make clean berry

ar rvs ../berry.a src/*.o default/*.o
