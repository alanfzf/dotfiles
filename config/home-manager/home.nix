{ config, pkgs, ... }:

# useful reference: `man home-configuartion.nix`

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "alan";
  home.homeDirectory = "/home/alan";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
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
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  home.file = {
	  ".config/nvim".source = ../nvim;
	  ".config/git".source = ../git;
	  ".config/tmux".source = ../tmux;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # shells
  programs.bash = {
    enable = true;
    shellAliases = {
      vi ="nvim";
    };
    initExtra = ''
    eval "$(keychain -q --eval --agents ssh ~/.ssh/id_ed25519)"
    '';
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
    enableZshIntegration = true;
  };

  # ssh
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
  };
}
