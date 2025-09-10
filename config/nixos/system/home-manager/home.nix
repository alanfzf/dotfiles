{
  homeUser,
  config,
  lib,
  pkgs,
  ...
}:
let
  isLinux = pkgs.stdenv.hostPlatform.isLinux;
in
{

  home.username = homeUser;
  home.stateVersion = "24.11";
  home.homeDirectory = (
    if isLinux then "/home/${config.home.username}" else "/Users/${config.home.username}"
  );

  home.sessionVariables = {
    EDITOR = "$(which nvim)";
    VISUAL = "$(which nvim)";
  };

  home.shellAliases = {
    vi = "nvim";
    vif = "fzf --preview 'bat {}' | xargs -r nvim";
    ls = "eza -l --icons -s extension";
    cat = "bat";
    lg = "lazygit";
    k = "kubectl";
  };

  home.packages = with pkgs; [
    neovim
    awscli2
    bat
    eza
    fd
    fzf
    gcc
    gh
    git
    jq
    k9s
    kubectl
    kubernetes-helm
    lazygit
    lua-language-server
    nerd-fonts.jetbrains-mono
    nixfmt-rfc-style
    stylua
    tmux
    unzip
    # new stuff
    tree-sitter
    copilot-language-server-fhs
    aider-chat

    (pkgs.writeShellApplication {
      name = "calc";
      text = ''
        if [ -z "$1" ]; then
          echo "Usage: $0 \"EXPRESSION\""
          exit 1
        fi

        awk "BEGIN { print $1 }"
      '';
    })

  ];

  home.file = {
    ".config/qtile".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/qtile"
    );
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
    ".config/lf".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/lf"
    );
    ".config/foot".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/foot"
    );
    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/waybar"
    );
    ".config/mako".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/mako"
    );
    ".ideavimrc".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/ideavim/ideavimrc"
    );
    ".config/swaylock".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/swaylock"
    );
    ".aider.conf.yml".source = config.lib.file.mkOutOfStoreSymlink (
      config.home.homeDirectory + "/.dotfiles/config/aider.conf.yml"
    );
  };

  programs.home-manager = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    autocd = false;
    completionInit = ''
      autoload -Uz compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
  };

  programs.readline = {
    enable = true;
    variables = {
      expand-tilde = true;
      completion-ignore-case = true;
      show-all-if-ambiguous = true;
    };
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
    config = {
      global = {
        warn_timeout = "1m";
      };
      whitelist = {
        prefix = [ "~/projects" ];
      };
    };
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

  programs.keychain = {
    enable = true;
    keys = [
      "id_ed25519"
    ];
  };

  programs.ssh = {
    enable = true;
    includes = [ "*.conf" ];
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        serverAliveInterval = 240;
        forwardAgent = true;
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519.pub";
      };
      "corpo" = {
        hostname = "172.31.89.33";
        user = "ubuntu";
        identityFile = "~/.ssh/Corposistemas.pem";
      };
    };
  };
}
