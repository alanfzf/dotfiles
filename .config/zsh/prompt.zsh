# Docs: https://arjanvandergaag.nl/blog/customize-zsh-prompt-with-vcs-info.html

# VARIABLES
RED="%F{red}"
GREEN="%F{green}"
BLUE="%F{blue}"
CYAN="%F{cyan}"
YELLOW="%F{yellow}"

# GIT INFO
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:git:*' formats "%{$BLUE%}git:(%{$RED%}%b%{$BLUE%}) "
zstyle ':vcs_info:git:*' actionformats "%{$BLUE%}git:(%{$RED%}%b%{$BLUE%}) %{$YELLOW%}%a "

precmd() {
    vcs_info
}

# DEFINE PROMPT
setopt prompt_subst
PROMPT='%(?.$GREEN.$RED)➜%f %{$CYAN%}%2~ ${vcs_info_msg_0_}%f'
