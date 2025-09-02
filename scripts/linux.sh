mkdir -p ~/.config/nix && echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

if ! grep -qi "nixos" /etc/os-release; then
    # NOT nixos!
    sudo apt update && \
        sudo apt upgrade -y && \
        sudo apt install curl xz-utils openssh-client uidmap -y

    curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes

    nix shell nixpkgs#home-manager nixpkgs#git --command sh -c "\
        git clone https://github.com/alanfzf/dotfiles $HOME/.dotfiles \
        && home-manager switch --flake $HOME/.dotfiles/config/nixos -b bckp"
else
    echo "not done yet"
fi
