#!/bin/bash

BASE_PATH=$(dirname $0)

cd $BASE_PATH
source .env

export RBENV_VERSION=$RUBY_VERSION
eval "$(rbenv init -)"

bundle config --local path vendor/bundler
bundle config --local bin vendor/bin
# bundle package
bundle install --local
