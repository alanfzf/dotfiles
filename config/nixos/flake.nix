{
  description = "Alan's Nix system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # darwin
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # neovim overlay
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-darwin,
      ...
    }@inputs:
    let
      # users
      user = "alan";
      workUser = "corpo";

      # overlay
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];

      # functions
      importPkgs =
        system:
        import nixpkgs {
          system = system;
          config = {
            allowUnfree = true;
          };
        };

      homeConfig =
        user: system: pkgs:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            {
              nixpkgs.overlays = overlays;
            }
            ./system/home-manager/home.nix
          ];
          extraSpecialArgs = {
            homeUser = user;
          };
        };

      # architecture declaration
      system = "x86_64-linux";
      pkgs = importPkgs system;

      aarchSystem = "aarch64-darwin";
      aarchPkgs = importPkgs aarchSystem;

    in
    {
      # Native Nix machine
      nixosConfigurations = {
        "nixos" = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = overlays;
            }
            ./system/configuration.nix
          ];
          specialArgs = {
            inherit inputs user;
          };
        };
      };

      # MacOS
      darwinConfigurations = {
        "mb-pro-m3" = nix-darwin.lib.darwinSystem {
          system = aarchSystem;
          modules = [ ./system/darwin/darwin.nix ];
          specialArgs = { inherit inputs; };
        };
      };

      # home-manager
      homeConfigurations = {
        "${user}" = homeConfig user system pkgs;
        "${workUser}" = homeConfig workUser system pkgs;
      };
    };
}
