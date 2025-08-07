{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/desktop/hyprland.nix
    ../../users/ebn.nix
  ];

  networking.hostName = "zeezrom";

  system.stateVersion = "25.05";
}
