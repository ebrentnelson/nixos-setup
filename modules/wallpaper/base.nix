{ config, pkgs, wallpaperCommand }:

let
  wallpaperScript = pkgs.writeShellScript "set-random-wallpaper" ''
    WALLPAPER_DIR="$HOME/Dropbox/Wallpapers"
    
    if [ ! -d "$WALLPAPER_DIR" ]; then
      echo "Wallpaper directory $WALLPAPER_DIR not found"
      exit 1
    fi
    
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)
    
    if [ -z "$WALLPAPER" ]; then
      echo "No wallpaper found in $WALLPAPER_DIR"
      exit 1
    fi

    TEMP_WALLPAPER="/tmp/filtered_wallpaper.jpg"

    ${pkgs.imagemagick}/bin/convert "$WALLPAPER" \
      -colorspace Gray \
      -normalize \
      -sigmoidal-contrast 5,50% \
      -level 25%,75% \
      "$TEMP_WALLPAPER"
    
    echo "Setting wallpaper: $WALLPAPER"
    ${wallpaperCommand}
    echo "Script completed"
  '';
in
{
  systemd.user.services.random-wallpaper = {
    description = "Set random wallpaper from Dropbox";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${wallpaperScript}";
    };
  };

  systemd.user.timers.random-wallpaper = {
    description = "Change wallpaper hourly";
    timerConfig = {
      OnCalendar = "hourly";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };
}
