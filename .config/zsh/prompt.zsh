# !/bin/zsh -e

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}"
zstyle ':vcs_info:git:*' unstagedstr "%F{cyan}"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

PROMPT='
[%B%F{magenta}%n@%m%f%b:%F{green}%(5~,%-1~/.../%2~,%~)%f]%F{cyan}$vcs_info_msg_0_%f
%F{magenta}%B$%b%f '
