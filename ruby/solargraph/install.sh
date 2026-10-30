#!/bin/bash

BASE_PATH=$(dirname $0)

cd $BASE_PATH
source env.sh

eval "$(mise env -s bash ruby@$RUBY_VERSION)"

bundle config --local path vendor/bundler
bundle config --local bin vendor/bin

# NOTE: gemを変更するときにコメントアウトを外す
# bundle package

bundle install --local
