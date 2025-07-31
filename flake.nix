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

  outputs = { self, nixpkgs, home-manager, disko, ... }:
    let
      # Clean function to create systems with dynamic disk argument
      mkSystem = hostname:
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./disk-config.nix
            disko.nixosModules.disko
            ({pkgs, ...}: {
              boot.loader = {
                systemd-boot.enable = true;
                efi.canTouchEfiVariables = true;
              }
            })
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
      nixosConfigurations = {
        moroni = mkSystem "moroni";
        # nephi = mkSystem "nephi";
        # alma = mkSystem "alma";
        # helaman = mkSystem "helaman";
        # Easy to add new machines - just one line each
      };
    };
}
