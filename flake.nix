{
  description = "NixOS configuration with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    hostname = "moroni";  # Change this one line to rename the host
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        /etc/nixos/hardware-configuration.nix
        home-manager.nixosModules.home-manager
        {
          networking.hostName = hostname;
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.ebn = import ./users/ebn/home.nix;
          };
        }
      ];
    };
  };
}
