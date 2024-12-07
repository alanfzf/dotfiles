{config, pkgs, ...}:
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

  virtualisation.docker.enable = true;
}
