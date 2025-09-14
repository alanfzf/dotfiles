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
    ./packages.nix
    ./users.nix
    ./wsl.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  system.stateVersion = "25.05";
}
