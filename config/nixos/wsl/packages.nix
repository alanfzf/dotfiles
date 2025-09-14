{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [

    (writeShellApplication {
      name = "switch-wpc";
      text = ''
        sudo nixos-rebuild switch --flake ~/.dotfiles/config/nixos#wpc
      '';
    })
  ];

  programs.zsh = {
    enable = true;
  };
}
