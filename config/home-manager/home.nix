# Useful reference: `man home-configuartion.nix`
{ config, pkgs, ... }: {
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "alan";
  home.homeDirectory = "/home/${config.home.username}";
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
    pkgs.bat
    pkgs.eza
    pkgs.lazygit
    pkgs.gcc
    pkgs.openssh
    pkgs.keychain
    pkgs.awscli2
    pkgs.jq
    # misc
    pkgs.stylua
    pkgs.lua-language-server
    pkgs.marksman
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  home.file = {
    ".config/nvim".source          = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/config/nvim");
    ".config/git".source           = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/config/git");
    ".config/tmux".source          = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/config/tmux");
    ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/config/starship.toml");
    ".config/lazygit".source       = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/config/lazygit");
    ".config/bat".source           = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/config/bat");
    ".config/direnv".source        = config.lib.file.mkOutOfStoreSymlink (config.home.homeDirectory + "/.dotfiles/config/direnv");
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
    switch = "home-manager switch --flake $HOME/.dotfiles/config/home-manager";
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

  programs.ripgrep = {
    enable = true;
    arguments = [
      "--hidden"
      "--follow"
      "--glob=!{.git,node_modules,vendor}"
      "--glob=!*.{lock}"
      "--glob=!{package-lock.json}"
      "--max-columns=10000"
      "--smart-case"
      "--sort=path"
    ];
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    serverAliveInterval = 240;
    matchBlocks = {
      "alan" = {
        hostname = "gepnir.ovh";
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
