{ config, pkgs, ... }:

{
  imports = [
    (import ./base.nix {
      inherit config pkgs;
      wallpaperCommand = "${pkgs.swww}/bin/swww img \"$TEMP_WALLPAPER\" --transition-type fade --transition-duration 2 --resize crop";
    })
  ];
  
  environment.systemPackages = with pkgs; [ swww ];
}
