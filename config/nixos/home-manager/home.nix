{
  homeUser,
  config,
  lib,
  pkgs,
  ...
}:
{

  home.username = homeUser;
  home.homeDirectory = (
    if pkgs.stdenv.hostPlatform.isLinux then
      "/home/${config.home.username}"
    else
      "/Users/${config.home.username}"
  );

  home.stateVersion = "24.11";

  # Handle app symlinks
  # targets.genericLinux.enable = true;
  # xdg.mime.enable = true;
  # xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.shellAliases = {
    vi = "nvim";
    vif = "fzf --preview 'bat {}' | xargs -r nvim";
    ls = "eza -l --icons -s extension";
    cat = "bat";
    lg = "lazygit";
  };

  home.packages = with pkgs; [
    awscli2
    bat
    eza
    fd
    fzf
    gcc
    gh
    git
    jq
    lazygit
    lua-language-server
    marksman
    neovim
    stylua
    tmux
    unzip
    lf
    nixfmt-rfc-style
    podman
    kubernetes-helm
    kubectl
    nerd-fonts.jetbrains-mono
  ];

  home.file = {
    ".config/sway".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/sway"
    );
    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/nvim"
    );
    ".config/git".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/git"
    );
    ".config/tmux".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/tmux"
    );
    ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/starship.toml"
    );
    ".config/lazygit".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/lazygit"
    );
    ".config/bat".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/bat"
    );
    ".config/direnv".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/direnv"
    );
  };

  programs = {
    home-manager = {
      enable = true;
    };

    bash = {
      enable = true;
      enableCompletion = true;
    };

    zsh = {
      enable = true;
      enableCompletion = true;
      defaultKeymap = "emacs";
    };

    readline = {
      enable = true;
      variables = {
        expand-tilde = true;
        completion-ignore-case = true;
        show-all-if-ambiguous = true;
      };
    };

    zoxide = {
      enable = true;
    };

    starship = {
      enable = true;
    };

    direnv = {
      enable = true;
      silent = true;
    };

    ripgrep = {
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

    keychain = {
      enable = true;
      keys = [
        "id_ed25519"
        "id_ed25519_finanssoreal"
      ];
    };

    ssh = {
      enable = true;
      serverAliveInterval = 240;
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identitiesOnly = true;
          identityFile = "~/.ssh/id_ed25519.pub";
        };
        "alan-oracle" = {
          hostname = "oracle.gepnir.ovh";
          user = "ubuntu";
          identitiesOnly = true;
          identityFile = "~/.ssh/id_ed25519.pub";
        };
        "alan-ovh" = {
          hostname = "gepnir.ovh";
          user = "debian";
          identitiesOnly = true;
          identityFile = "~/.ssh/id_ed25519.pub";
        };
        "ftp" = {
          hostname = "ftp.finanssoreal.com";
          user = "ubuntu";
          identitiesOnly = true;
          identityFile = "~/.ssh/id_ed25519_finanssoreal.pub";
        };
        "testing" = {
          hostname = "testing.finanssoreal.com";
          user = "debian";
          identitiesOnly = true;
          identityFile = "~/.ssh/id_ed25519_finanssoreal.pub";
        };
        "prod" = {
          hostname = "control.finanssoreal.com";
          user = "debian";
          identitiesOnly = true;
          identityFile = "~/.ssh/id_ed25519_finanssoreal.pub";
        };
        "redia" = {
          hostname = "redia.codes";
          user = "debian";
          identitiesOnly = true;
          identityFile = "~/.ssh/id_ed25519_finanssoreal.pub";
        };
      };
    };
  };
}
