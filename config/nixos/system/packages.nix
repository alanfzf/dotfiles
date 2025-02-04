{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    grim
    mako
    slurp
    alacritty
    wl-clipboard
    brightnessctl
    rofi-wayland
    waypaper
    swaybg
    mako
    libnotify
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
}
