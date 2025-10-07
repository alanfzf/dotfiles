{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    foot
    grim
    jetbrains.datagrip
    libnotify
    mako
    openvpn
    playerctl
    rofi
    slurp
    swaybg
    waypaper
    wdisplays
    wl-clipboard
    mysql-client
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.thunar = {
    enable = true;
  };

  programs.firefox = {
    enable = true;
    preferences = {
      "general.autoScroll" = true;
    };
  };

  programs.zsh = {
    enable = true;
  };
}
