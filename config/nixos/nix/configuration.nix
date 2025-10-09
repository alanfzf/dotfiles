{
  config,
  pkgs,
  user,
  ...
}:
{
  imports = [
    ./locale.nix
    ./bootloader.nix
    ./network.nix
    ./services.nix
    ./packages.nix
    ./hardware-configuration.nix
    ./hardware.nix
    ../common/hm.nix
    ../common/users.nix
  ];

  system.stateVersion = "24.05";

  nix = {
    gc = {
      automatic = true;
      dates = "09:30";
      options = "--delete-older-than 7d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
