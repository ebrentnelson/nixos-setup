{ config, pkgs, ... }:

{
  imports = [
    (import ./base.nix {
      inherit config pkgs;
      wallpaperCommand = "${pkgs.feh}/bin/feh --bg-fill \"$TEMP_WALLPAPER\"";
    })
  ];
  
  environment.systemPackages = with pkgs; [ feh ];
}
