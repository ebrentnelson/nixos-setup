{ config, pkgs, ... }:

let
  wallpaperScript = pkgs.writeShellScript "set-random-wallpaper" ''
    WALLPAPER_DIR="$HOME/Dropbox/Wallpapers"
    
    if [ ! -d "$WALLPAPER_DIR" ]; then
      echo "Wallpaper directory $WALLPAPER_DIR not found"
      exit 1
    fi
    
    # Find all image files
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)
    
    if [ -z "$WALLPAPER" ]; then
      echo "No wallpaper found in $WALLPAPER_DIR"
      exit 1
    fi

    TEMP_WALLPAPER="/tmp/filtered_wallpaper.jpg"

    ${pkgs.imagemagick}/bin/convert "$WALLPAPER" \
      -colorspace Gray \
      -sigmoidal-contrast 10,50% \
      -level 15%,85% \
      -brightness-contrast 10x15 \
      "$TEMP_WALLPAPER"
    
    echo "Setting wallpaper: $WALLPAPER"
  
    # Check if swww-daemon is running (Wayland) or use feh (X11)
    if pgrep swww-daemon > /dev/null 2>&1; then
      echo "Using swww (Wayland detected)"
      ${pkgs.swww}/bin/swww img "$TEMP_WALLPAPER" --transition-type fade --transition-duration 2 --resize crop
    else
      echo "Using feh (X11 detected)"
      ${pkgs.feh}/bin/feh --bg-fill "$TEMP_WALLPAPER"
    fi
    
    echo "Script completed"
  '';
in
{
  environment.systemPackages = with pkgs; [
    swww  # For Wayland
    feh   # For X11
  ];

  # Timer to change wallpaper every hour
  systemd.user.services.random-wallpaper = {
    description = "Set random wallpaper from Dropbox";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${wallpaperScript}";
    };
    environment = {
      WAYLAND_DISPLAY = "wayland-1";
      XDG_RUNTIME_DIR = "/run/user/1000";
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
