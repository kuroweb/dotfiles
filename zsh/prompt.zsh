#!/bin/zsh

#
# prompt
#

function powerline_precmd() {
    PS1="$(powerline-shell --shell zsh)"$'\n'"$ "
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" -a -x "$(command -v powerline-shell)" ]; then
    install_powerline_precmd
fi

precmd() { powerline_precmd }
