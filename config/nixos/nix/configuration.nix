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
    ./users.nix
    ./services.nix
    ./packages.nix
    ./hardware-configuration.nix
    ./hardware.nix
    ./hm.nix
  ];

  system.stateVersion = "24.05";

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

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
