set fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vi nvim
alias gs "git status"
alias cat batcat
alias lg lazygit

starship init fish | source
zoxide init fish | source
