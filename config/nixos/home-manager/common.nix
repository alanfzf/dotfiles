{
  homeUser,
  config,
  pkgs,
  ...
}:
{

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
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
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
      ];
    };

    ssh = {
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
        "cs2" = {
          hostname = "51.222.206.82";
          user = "debian";
          identityFile = "~/.ssh/id_ed25519";
        };
      };
    };
  };
}
