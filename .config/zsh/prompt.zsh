#!/bin/zsh

#
# prompt
#

# autoload -Uz vcs_info
# setopt prompt_subst
# zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' stagedstr "%F{magenta}"
# zstyle ':vcs_info:git:*' unstagedstr "%F{cyan}"
# zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# precmd () { vcs_info }
# PROMPT='
# [%B%F{magenta}%n@%m%f%b:%F{green}%(5~,%-1~/*/%2~,%~)%f]%F{cyan}$vcs_info_msg_0_%f
# %F{magenta}%B$%b%f '

precmd () { powerline_precmd }

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
