{ config, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      # Modifier key (Super/Windows key)
      modifier = "Mod4";
      
      # Application launcher
      menu = "rofi -show drun -theme ~/.config/rofi/theme.rasi";
      bars = [];
      
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
        { command = "polybar main"; notification = false; }
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
        "${modifier}+space" = "exec rofi -show drun -theme ~/.config/rofi/theme.rasi";
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
      
      colors = {
        focused = {
          border = "#fe386e";
          background = "#111111";
          text = "#f9f9f9";
          indicator = "#fe386e";
          childBorder = "#fe386e";
        };
        unfocused = {
          border = "#333333";
          background = "#1a1a1a";
          text = "#888888";
          indicator = "#333333";
          childBorder = "#333333";
        };
        focusedInactive = {
          border = "#444444";
          background = "#222222";
          text = "#cccccc";
          indicator = "#444444";
          childBorder = "#444444";
        };
        urgent = {
          border = "#fe386e";
          background = "#fe386e";
          text = "#ffffff";
          indicator = "#fe386e";
          childBorder = "#fe386e";
        };
      };
    };
  };

  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 4;
    fadeSteps = [ 0.03 0.03 ];
    shadow = true;
    shadowOpacity = 0.75;
    shadowOffsets = [ (-15) (-15) ];
    shadowExclude = [
      "class_g = 'i3-frame'"
      "class_g ?= 'rofi'"
      "_GTK_FRAME_EXTENTS@:c"
    ];
    activeOpacity = 1.0;
    inactiveOpacity = 0.95;
    opacityRules = [
      "100:class_g = 'firefox'"
      "100:class_g = 'Chromium-browser'"
      "95:class_g = 'ghostty'"
      "100:class_g = 'Rofi'"
      "90:class_g = 'Thunar'"
    ];
    backend = "glx";
    vSync = true;
    settings = {
      shadow-radius = 12;
      corner-radius = 8;
      rounded-corners-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
      ];
      blur-method = "gaussian";
      blur-size = 10;
      blur-deviation = 5.0;
      blur-background-exclude = [
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "_GTK_FRAME_EXTENTS@:c"
      ];
    };
  };
}
