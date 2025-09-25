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
      "browser.cache.disk.enable" = false;
      "browser.cache.memory.enable" = false;
      "browser.sessionhistory.max_entries" = 5;
      "browser.sessionhistory.max_total_viewers" = 0;
      "browser.sessionstore.interval" = 600000;
      "extensions.pocket.enabled" = false;
      "general.autoScroll" = true;
      "network.prefetch-next" = false;
    };
  };

  programs.zsh = {
    enable = true;
  };
}
