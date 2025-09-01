{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mako
    slurp
    wl-clipboard
    rofi-wayland
    waypaper
    swaybg
    mako
    libnotify
    wdisplays
    playerctl
    microsoft-edge
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.waybar = {
    enable = true;
  };

  programs.thunar = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
  };
}
