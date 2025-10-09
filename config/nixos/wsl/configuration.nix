{
  config,
  lib,
  pkgs,
  user,
  inputs,
  ...
}:
{

  imports = [
    inputs.nixos-wsl.nixosModules.default
    ./services.nix
    ./packages.nix
    ./wsl.nix
    ../common/hm.nix
    ../common/users.nix
  ];

  system.stateVersion = "25.05";
}
