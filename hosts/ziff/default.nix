{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/desktop/i3.nix
    ../../modules/users/ebn.nix
    ../../modules/wallpaper/x11.nix
  ];

  networking.hostName = "ziff";

  system.stateVersion = "25.05";
}
