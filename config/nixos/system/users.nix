{ pkgs, ... }:
{
  users.users = {
    "alan" = {
      # NOTE: don't manage user packages here, use home-manager instead
      isNormalUser = true;
      description = "alan";
      shell = pkgs.zsh;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
