{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    foot
    grim
    jetbrains.datagrip
    libnotify
    mako
    microsoft-edge
    openvpn
    playerctl
    rofi
    slurp
    swaybg
    waypaper
    wdisplays
    wl-clipboard
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.thunar = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
  };
}
