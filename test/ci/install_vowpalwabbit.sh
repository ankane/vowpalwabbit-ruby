#!/usr/bin/env bash

set -e

CACHE_DIR=$HOME/vowpalwabbit/$VOWPALWABBIT_VERSION

if [ ! -d "$CACHE_DIR" ]; then
  git clone --recursive --branch $VOWPALWABBIT_VERSION https://github.com/VowpalWabbit/vowpal_wabbit.git
  mv vowpal_wabbit $CACHE_DIR
  cd $CACHE_DIR
  mkdir build
  cd build
  cmake ..
  make
else
  echo "Vowpal Wabbit cached"
fi
