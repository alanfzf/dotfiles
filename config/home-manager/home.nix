# Useful reference: `man home-configuartion.nix`
{ config, pkgs, ... }: {
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "alan";
  home.homeDirectory = "/home/alan";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.git
    pkgs.neovim
    pkgs.tmux
    pkgs.gh
    pkgs.fzf
    pkgs.fd
    pkgs.ripgrep
    pkgs.bat
    pkgs.eza
    pkgs.lazygit
    pkgs.gcc
    pkgs.openssh
    pkgs.keychain
    # misc
    pkgs.stylua
    pkgs.lua-language-server
    pkgs.marksman
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  home.file = {
    ".config/nvim".source = ../nvim;
    ".config/git".source = ../git;
    ".config/tmux".source = ../tmux;
    ".config/starship.toml".source = ../starship.toml;
    ".config/lazygit".source = ../lazygit;
    ".config/bat".source = ../bat;
    ".config/direnv".source = ../direnv;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases = {
    vi  = "nvim";
    vif = "fzf --preview 'bat {}' | xargs -r nvim";
    ls  = "eza -l --icons -s extension";
    cat = "bat";
    lg  = "lazygit";
    switch = "home-manager switch --flake $HOME/.dotfiles/config/home-manager#x86";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # shells
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    defaultKeymap = "emacs";
  };

  # other programs
  programs.readline = {
    enable = true;
    variables = {
      expand-tilde = true;
      completion-ignore-case = true;
      show-all-if-ambiguous = true;
    };
  };

  programs.keychain = {
    enable = true;
    keys = [
      "id_ed25519"
    ];
  };

  programs.zoxide = {
    enable = true;
  };

  programs.starship = {
    enable = true;
  };

  programs.direnv = {
    enable = true;
    silent = true;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    matchBlocks = {
      "alan" = {
        hostname = "pruebas.alanfzf.site";
        user = "ubuntu";
      };
      "ftp" = {
        hostname = "ftp.finanssoreal.com";
        user = "ubuntu";
        identityFile = "~/.ssh/ed25519_finanssoreal";
      };
      "testing" = {
        hostname = "testing.finanssoreal.com";
        user = "debian";
        identityFile = "~/.ssh/ed25519_finanssoreal";
      };
      "prod" = {
        hostname = "control.finanssoreal.com";
        user = "debian";
        identityFile = "~/.ssh/ed25519_finanssoreal";
      };
    };
  };
}
