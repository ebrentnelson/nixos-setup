{ config, pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland.enable = true;

  # Hyprland-specific system packages
  environment.systemPackages = with pkgs; [
    waybar
    mako
    wofi
    grim
    slurp
    wl-clipboard
  ];
}
