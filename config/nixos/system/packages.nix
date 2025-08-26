{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    grim
    mako
    slurp
    wl-clipboard
    brightnessctl
    rofi-wayland
    waypaper
    swaybg
    mako
    libnotify
    wdisplays
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

  programs.firefox = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
  };
}
