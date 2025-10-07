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
    brave
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.thunar = {
    enable = true;
  };

  programs.chromium = {
    enable = true;
    extensions = [
      # vimium
      "dbepggeogbaibhgnhhndojpepiihcmeb"
      # dark reader
      "eimadpbcbfnmbkopoojfekhnkhdbieeh"
      # bitwarden
      "nngceckbapebfimnlniiiahkandclblb"
    ];
    extraOpts = {
      "AutoFillEnabled" = false;
      "BraveAIChatEnabled" = false;
      "BraveNewsDisabled" = true;
      "BraveRewardsDisabled" = true;
      "BraveWalletDisabled" = true;
      "PasswordManagerEnabled" = false;
      "PromotionalTabsEnabled" = false;
    };
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
