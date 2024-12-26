{
  homeUser,
  config,
  pkgs,
  ...
}:
{

  imports = [
    ./common.nix
  ];

  home.username = homeUser;
  home.homeDirectory = "/home/${config.home.username}";
  home.stateVersion = "24.11";

  # Handle app symlinks
  targets.genericLinux.enable = true;
  xdg.mime.enable = true;
  xdg.systemDirs.data = [ "${config.home.homeDirectory}/.nix-profile/share/applications" ];
}
