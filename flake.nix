{
  description = "Cross platform development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
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
            extraSpecialArgs = {
              gitConfig = {
                userName = "Elliot Blackburn";
                userEmail = "elliot@lybrary.io";
                gpgSshProgram = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
                signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF3fznw303UZ4U+35laeeSuY4VMCKIDsT/ZGpSbQGQpi";
              };
            };
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
            extraSpecialArgs = {
              gitConfig = {
                userName = "Elliot Blackburn";
                userEmail = "elliot@sunbeam.cx";
                gpgSshProgram = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
                signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHmR5JHdpexNp5VF/o/ikU1ET384vmwKL1KI4nVZbnHO";
              };
            };
          };
        }
      ];
    };

    # Ubuntu/Linux configuration (standalone home-manager)
    # Activate with: home-manager switch --flake .#elliot@hostname
    homeConfigurations."elliot@desktop" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg)
        [
          "terraform"
        ];
      };
      modules = [
        ./home-manager/linux-personal.nix
      ];
      extraSpecialArgs = {
        gitConfig = {
          userName = "Elliot Blackburn";
          userEmail = "elliot@lybrary.io";
          gpgSshProgram = "/opt/1Password/op-ssh-sign";
          signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICuTYLig+zGIUpsAR3fjVbarktmpYyxJrM0ViVzdOuCe";
        };
      };
    };
  };
}
