{
  description = "Alan nix system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    # home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }:
    let
      # x86 declarations
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = "${system}";
        config = {
          allowUnfree = true;
        };
      };

      # aarch64 declarations
      aarchSystem = "aarch64-darwin";
      aarchPkgs = import nixpkgs {
        system = "${aarchSystem}";
        config = {
          allowUnfree = true;
        };
      };


    in {
      # Native Nix machine
      nixosConfigurations = {
        "nixos" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./system/configuration.nix ];
        };
      };

      # MacOS
      darwinConfigurations = {
        "simple" = nix-darwin.lib.darwinSystem {
          modules = [./darwin/darwin.nix];
        };
      };

      # home-manager
      homeConfigurations = {
        "alan@nixos" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home-manager/home.nix ];
        };

        "finanssorealsa@mb-pro-m3" = home-manager.lib.homeConfigurations {
          inherit aarchPkgs;
          modules = [ ./home-manager/home.nix ];
        }
      };
    };
}
