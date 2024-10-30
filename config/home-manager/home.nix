# Useful reference: `man home-configuartion.nix`
{ config, pkgs, ... }: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
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
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # shells
  programs.bash = {
    enable = true;
    shellAliases = {
      vi  = "nvim";
      vif = "fzf --preview 'bat {}' | xargs -r nvim";
      ls  = "eza -l --icons -s extension";
      cat = "bat";
      lg  = "lazygit";
      switch = "home-manager switch --flake ~/.dotfiles/config/home-manager/";
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    defaultKeymap = "emacs";
    shellAliases = {
      vi ="nvim";
    };
  };

  # other programs
  programs.zoxide = {
    enable = true;
  };

  programs.keychain = {
    enable = true;
    keys = [
      "id_ed25519"
    ];
  };

  programs.starship = {
    enable = true;
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
    };
  };
}
