{ config, pkgs, ... }:

{
  imports = [
    ./locale.nix
    ./bootloader.nix
    ./network.nix
    ./users.nix
    ./services.nix
    ./packages.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "24.05";

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
