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
    ./hm.nix
    ./services.nix
    ./programs.nix
    ./users.nix
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  wsl.enable = true;
  wsl.defaultUser = user;
  system.stateVersion = "25.05";
}
