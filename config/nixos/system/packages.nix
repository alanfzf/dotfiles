{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ghostty
    grim
    jetbrains.datagrip
    libnotify
    mako
    microsoft-edge
    openvpn
    playerctl
    rofi-wayland
    slurp
    waypaper
    wdisplays
    wl-clipboard
  ];

  programs.thunar = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
  };
}
