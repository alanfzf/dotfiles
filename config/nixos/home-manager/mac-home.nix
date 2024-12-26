{ homeUser, config, pkgs, ...}: {

  imports = [
    ./common.nix
  ];

  home.username = homeUser;
  home.homeDirectory = "/Users/${config.home.username}";
  home.stateVersion = "24.11";
}
