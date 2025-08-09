{ config, pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland.enable = true;

  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  # Hyprland-specific system packages
  environment.systemPackages = with pkgs; [
    waybar
    mako
    wofi
    grim
    slurp
    wl-clipboard
    wlogout
  ];
}
