{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/desktop/i3.nix
    ../../modules/users/ebn.nix
  ];

  networking.hostName = "moroni";

  system.stateVersion = "25.05";
}
