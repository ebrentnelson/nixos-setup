{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/common.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/users/ebn.nix
    ../../modules/wallpaper.nix
  ];

  networking.hostName = "zeezrom";

  system.stateVersion = "25.05";
}
