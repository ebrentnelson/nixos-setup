{ config, pkgs, ... }:

{
  # Enable X11 with i3
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status  
        i3lock   
        i3blocks
      ];
    };
  };

  # i3-specific system packages
  environment.systemPackages = with pkgs; [
     rofi
     polybar
     feh 
     scrot 
     xclip
     picom
     arandr 
  ];
}
