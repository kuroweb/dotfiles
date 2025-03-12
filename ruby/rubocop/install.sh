#!/bin/bash

BASE_PATH=$(dirname $0)

cd $BASE_PATH
source env.sh

export RBENV_VERSION=$RUBY_VERSION
eval "$(rbenv init -)"

bundle config --local path vendor/bundler
bundle config --local bin vendor/bin

# NOTE: gemを変更するときにコメントアウトを外す
# bundle package

bundle install --local
