#!/bin/zsh

# homebrew
export PATH=/usr/local/bin:$PATH

# editor
export EDITOR=nvim

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# go
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export GO111MODULE=on
eval "$(goenv init -)"

# node
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
