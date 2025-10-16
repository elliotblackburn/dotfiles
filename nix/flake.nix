{
  description = "Cross platform development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#elliot@macos-personal
    darwinConfigurations."elliot@macos-personal" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./macos.nix

        # Allow unfree packages
        { nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg)
          [
            "terraform"
          ];
        }

        home-manager.darwinModules.home-manager
        {
          users.users.elliot.home = "/Users/elliot";
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.elliot = import ./home-manager/macos-personal.nix;
          };
        }
      ];
    };

    darwinConfigurations."elliot@macos-work" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./macos.nix

        # Allow unfree packages
        { nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg)
          [
            "terraform"
          ];
        }

        home-manager.darwinModules.home-manager
        {
          users.users.elliot.home = "/Users/elliot";
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.elliot = import ./home-manager/macos-work.nix;
          };
        }
      ];
    };

    # Ubuntu/Linux configuration (standalone home-manager)
    # Activate with: home-manager switch --flake .#elliot@hostname
    # homeConfigurations."elliot@hostname" = home-manager.lib.homeManagerConfiguration {
    #   pkgs = import nixpkgs {
    #     system = "x86_64-linux";
    #     config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg)
    #     [
    #       "terraform"
    #     ];
    #   };
    #   modules = [
    #     (import ./home-manager/home.nix {
    #       username = "elliot";
    #       homeDirectory = "/home/elliot";
    #     })
    #     ./home-manager/linux.nix
    #   ];
    # };
  };
}
