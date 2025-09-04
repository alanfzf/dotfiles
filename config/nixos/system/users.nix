{ pkgs, user, ... }:
{
  users.users = {
    "${user}" = {
      isNormalUser = true;
      description = "Default user";
      shell = pkgs.zsh;
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
    };
  };
}
