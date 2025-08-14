{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/minimal.nix
  ];

  networking.hostName = "ziff";

  system.stateVersion = "25.05";
}
