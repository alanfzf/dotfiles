{
  description = "Alan NixOS system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

    # nixos machine
    nixosConfigurations.nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./hardware/hardware-configuration.nix
          ./system/configuration.nix
        ];
    };

    homeConfigurations = {
      "alan@nixos" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home-manager/home.nix
          ];
      };
    };
  };
}
