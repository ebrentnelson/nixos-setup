{
  description = "NixOS configuration with Home Manager and Disko";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, ... }: {
    # Default configuration - you can still use this
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./disko.nix
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.ebn = import ./ebn.nix;
          };
        }
      ];
    };

    # Helper function to create configurations with custom hostnames
    nixosConfigurations = 
      let
        mkSystem = hostname: nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit hostname; };
          modules = [
            ./configuration.nix
            ./disko.nix
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            {
              networking.hostName = hostname;
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.ebn = import ./home.nix;
              };
            }
          ];
        };
      in {
        # Default fallback
        default = mkSystem "nixos";
        
        # Predefined hosts (optional - for commonly used machines)
        moroni = mkSystem "moroni";
        # nephi = mkSystem "nephi";
        # alma = mkSystem "alma";
      };
  };
}