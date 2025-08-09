{ config, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      # Modifier key (Super/Windows key)
      modifier = "Mod4";
      
      # Application launcher
      menu = "rofi -show drun";
      
      # Gaps configuration (similar to Hyprland)
      gaps = {
        inner = 5;
        outer = 5;
      };
      
      # Window configuration
      window = {
        border = 4;
        titlebar = false;
        commands = [
          {
            criteria = { class = "com.mitchellh.ghostty"; };
            command = "border pixel 4";
          }
        ];
      };
      
      # Startup applications
      startup = [
        { command = "nm-applet"; notification = false; }
        { command = "dropbox start"; notification = false; }
        { command = "picom"; notification = false; }  # Compositor
        { command = "feh --bg-fill --randomize ~/.config/wallpapers/*"; notification = false; }  # Wallpaper
        { command = "autotiling"; notification = false; }  # Automatic smart tiling
        { command = "xset s off"; notification = false; }  # Disable screensaver
        { command = "xset -dpms"; notification = false; }  # Disable DPMS
        { command = "xset s noblank"; notification = false; } # Disable screen blanking 
      ];
      
      # Keybindings (adapted from your Hyprland config)
      keybindings = let
        modifier = config.xsession.windowManager.i3.config.modifier;
        terminal = "ghostty";
        browser = "chromium --new-window --ozone-platform=x11";
        webapp = "${browser} --app";
      in {
        # Terminal
        "${modifier}+Return" = "exec ${terminal}";
        
        # Application shortcuts
        "${modifier}+f" = "exec thunar";
        "${modifier}+b" = "exec ${browser}";
        "${modifier}+space" = "exec rofi -show drun";
        "${modifier}+m" = "exec spotify";
        "${modifier}+n" = "exec ${terminal} -e nvim";
        "${modifier}+o" = "exec obsidian";
        
        # Web app bindings (adapted from your Hyprland config)
        "${modifier}+a" = "exec ${webapp}='https://claude.ai/new/'";
        "${modifier}+e" = "exec ${webapp}='https://mail.google.com/'";
        "${modifier}+c" = "exec ${webapp}='https://calendar.google.com/'";
        "${modifier}+Shift+g" = "exec ${webapp}='https://web.whatsapp.com/'";
        "${modifier}+Shift+h" = "exec ${webapp}='https://messages.google.com/web/'";

        # Change wallpaper manually  
        "${modifier}+comma" = "exec systemctl --user start random-wallpaper.service";
        
        # Window management
        "${modifier}+w" = "kill";
        "${modifier}+v" = "floating toggle";
        
        # Split controls (like Hyprland's behavior)
        "${modifier}+h" = "split h";  # Split horizontally (new window to the right)
        "${modifier}+j" = "split v";  # Split vertically (new window below)
        "${modifier}+t" = "split toggle";  # Toggle split direction
        
        # Layout modes
        "${modifier}+s" = "layout stacking";   # Stack windows vertically
        "${modifier}+Tab" = "layout tabbed";   # Tab layout
        "${modifier}+d" = "layout default";   # Default tiling
        "${modifier}+p" = "layout toggle split"; # Toggle between h/v splits
        
        # Focus movement
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";
        
        # Move windows
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";
        
        # Workspaces
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";
        
        # Move to workspaces
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";
        
        # Workspace navigation
        "Ctrl+Left" = "workspace prev";
        "Ctrl+Right" = "workspace next";
        
        # Resize windows
        "${modifier}+minus" = "resize shrink width 100px";
        "${modifier}+equal" = "resize grow width 100px";
        "${modifier}+Shift+minus" = "resize shrink height 100px";
        "${modifier}+Shift+equal" = "resize grow height 100px";
        
        # Screenshots (using scrot instead of grim/slurp)
        "Print" = "exec scrot -s ~/Pictures/screenshot_%Y-%m-%d_%H-%M-%S.png";
        "Shift+Print" = "exec scrot ~/Pictures/screenshot_%Y-%m-%d_%H-%M-%S.png";
        
        # Audio controls
        "XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        
        # Brightness controls
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        
        # System
        "${modifier}+Shift+r" = "restart";
        "${modifier}+Shift+e" = "exec i3-msg exit";
      };
      
      # Window rules
      floating.criteria = [
        { class = "Pavucontrol"; }
        { class = "Nm-connection-editor"; }
      ];
      
      # Colors (similar to your Hyprland theme)
      colors = {
        focused = {
          border = "#33ccff";
          background = "#33ccff";
          text = "#ffffff";
          indicator = "#00ff99";
          childBorder = "#33ccff";
        };
        unfocused = {
          border = "#595959";
          background = "#595959";
          text = "#ffffff";
          indicator = "#595959";
          childBorder = "#595959";
        };
      };
    };
  };

  # Picom compositor configuration (for transparency and effects)
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 4;
    shadow = true;
    shadowOpacity = 0.75;
  };
}
