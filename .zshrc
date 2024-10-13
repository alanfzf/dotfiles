# aliases
alias sudo="sudo "
alias vi="nvim"
alias vif="fzf --preview 'bat {}' | xargs -r nvim"
alias ls='eza -l --icons -s extension'
alias gs="git status"
alias cat="bat"
alias lg="lazygit"

function dcr(){
  devcontainer up --workspace-folder $1 --config $2 --dotfiles-repository https://github.com/alanfzf/dotfiles
}

function docker_delete(){
  docker system prune -af && docker volume prune -af
}

# exports
export VISUAL="nvim"
export EDITOR="nvim"
export LC_ALL=en_US.UTF-8
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Set up the prompt
setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Evals
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(keychain -q --eval --agents ssh ~/.ssh/id_ed25519)"
