{ pkgs, user, ... }:
{
  users.users = {
    "${user}" = {
      # NOTE: don't manage user packages here, use home-manager instead
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
