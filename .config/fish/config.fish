set fish_greeting ""

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# env variables
set -x VISUAL nvim
set -x EDITOR nvim

# other
alias vi nvim
alias gs "git status"
alias cat batcat
alias lg lazygit
alias phpback "php artisan serve --host 0.0.0.0 --port 8001"
alias phpfront "php artisan serve --host 0.0.0.0 --port 8000"

starship init fish | source
zoxide init fish | source
