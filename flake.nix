{
  description = "NixOS configuration with Home Manager and Disko";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
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
        disko.nixosModules.disko
        {
          disko.devices = {
            disk.main = {
              device = "/dev/disk/by-id/some-disk-id";
              type = "disk";
              content = {
                type = "gpt";
                partitions = {
                  ESP = {
                    size = "512M";
                    type = "EF00";
                    content = {
                      type = "filesystem";
                      format = "vfat";
                      mountpoint = "/boot";
                    };
                  };
                  swap = {
                    size = "8G";
                    content = {
                      type = "swap";
                      resumeDevice = true;
                    };
                  };
                  root = {
                    size = "100%";
                    content = {
                      type = "filesystem";
                      format = "ext4";
                      mountpoint = "/";
                    };
                  };
                };
              };
            };
          };
        }
        ./configuration.nix
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
