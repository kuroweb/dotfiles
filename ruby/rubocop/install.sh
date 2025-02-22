#!/bin/bash

BASE_PATH=$(dirname $0)

cd $BASE_PATH
source .env

rbenv local $RUBY_VERSION
bundle config --local path vendor/bundler
bundle config --local bin vendor/bin
bundle install --local
