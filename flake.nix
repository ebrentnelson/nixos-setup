{
  description = "NixOS configuration with Home Manager and Disko";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, disko, ... }: 
  let
    hostname = "moroni";  # Change this one line to rename the host
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./disk-config.nix
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        {
          networking.hostName = hostname;
          
          boot.loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
          };
          
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.ebn = import ./users/ebn/home.nix;
          };
        }
      ];
    };

    # Expose disko config for the disko command
    diskoConfigurations.${hostname} = import ./disk-config.nix;
  };
}