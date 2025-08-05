{ config, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    # ... your existing config ...

    # Enhanced gaps
    gaps = {
      inner = 8;    # Increased for better spacing
      outer = 4;
      smartGaps = true;  # Remove gaps when only one window
    };

    # Better window styling
    window = {
      border = 3;     # Slightly thicker border
      titlebar = false;
      hideEdgeBorders = "smart";  # Hide borders when only one window
    };

    # Enhanced colors with modern theme
    colors = {
      focused = {
        border = "#33ccff";
        background = "#33ccff";
        text = "#1e1e2e";
        indicator = "#a6e3a1";
        childBorder = "#33ccff";
      };
      focusedInactive = {
        border = "#45475a";
        background = "#45475a";
        text = "#cdd6f4";
        indicator = "#45475a";
        childBorder = "#45475a";
      };
      unfocused = {
        border = "#313244";
        background = "#313244";
        text = "#cdd6f4";
        indicator = "#313244";
        childBorder = "#313244";
      };
      urgent = {
        border = "#f38ba8";
        background = "#f38ba8";
        text = "#1e1e2e";
        indicator = "#f38ba8";
        childBorder = "#f38ba8";
      };
    };

    # Enhanced startup with better wallpaper management
    startup = [
      { command = "nm-applet"; notification = false; }
      { command = "dropbox start"; notification = false; }
      { command = "picom"; notification = false; }
      { command = "autotiling"; notification = false; }

      # Better wallpaper setup - nitrogen is more reliable than feh
      { command = "nitrogen --restore"; notification = false; }

      # Set GTK theme
      { command = "lxappearance"; notification = false; always = false; }
    ];
  };

  # Polybar configuration (replaces waybar)
  services.polybar = {
    enable = true;
    script = "polybar main &";
    config = {
      "bar/main" = {
        # Position at top instead of bottom
        bottom = false;  # This moves it to the top

        width = "100%";
        height = 35;  # Slightly taller for better look

        # Enhanced colors with transparency
        background = "#cc1e1e2e";  # Semi-transparent dark background
        foreground = "#cdd6f4";

        # Rounded corners and borders
        radius = 8;
        border-size = 2;
        border-color = "#33ccff";

        # Padding and margins
        padding-left = 2;
        padding-right = 2;
        module-margin = 1;

        modules-left = "i3 title";
        modules-center = "date";
        modules-right = "filesystem pulseaudio battery network";

        # Better font setup
        font-0 = "GeistMono Nerd Font:size=11:weight=medium;3";
        font-1 = "GeistMono Nerd Font:size=14;3";  # For icons

        # Tray configuration
        tray-position = "right";
        tray-padding = 2;
        tray-background = "#33ccff";
      };
      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";

        # Focused workspace
        label-focused = " %name% ";
        label-focused-background = "#33ccff";
        label-focused-foreground = "#1e1e2e";
        label-focused-padding = 1;
        label-focused-font = 1;

        # Unfocused workspace
        label-unfocused = " %name% ";
        label-unfocused-background = "#45475a";
        label-unfocused-foreground = "#cdd6f4";
        label-unfocused-padding = 1;

        # Urgent workspace
        label-urgent = " %name% ";
        label-urgent-background = "#f38ba8";
        label-urgent-foreground = "#1e1e2e";
        label-urgent-padding = 1;
      };

      # Window title module
      "module/title" = {
        type = "internal/xwindow";
        format = "<label>";
        label = "%title%";
        label-maxlen = 50;
        label-foreground = "#cdd6f4";
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%a %b %d";
        time = "%H:%M:%S";
        label = "  %date%   %time% ";
        format-background = "#313244";
        format-padding = 2;
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume = "<ramp-volume> <label-volume>";
        format-volume-background = "#313244";
        format-volume-padding = 2;

        label-muted = "  muted";
        label-muted-background = "#f38ba8";
        label-muted-foreground = "#1e1e2e";
        label-muted-padding = 2;

        ramp-volume-0 = " ";
        ramp-volume-1 = " ";
        ramp-volume-2 = " ";
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT0";
        adapter = "ADP1";

        format-charging = "  <label-charging>";
        format-charging-background = "#a6e3a1";
        format-charging-foreground = "#1e1e2e";
        format-charging-padding = 2;

        format-discharging = "<ramp-capacity> <label-discharging>";
        format-discharging-background = "#313244";
        format-discharging-padding = 2;

        ramp-capacity-0 = " ";
        ramp-capacity-1 = " ";
        ramp-capacity-2 = " ";
        ramp-capacity-3 = " ";
        ramp-capacity-4 = " ";
      };

      "module/network" = {
        type = "internal/network";
        interface = "wlan0";  # Adjust to your interface

        format-connected = "  <label-connected>";
        format-connected-background = "#313244";
        format-connected-padding = 2;
        label-connected = "%essid%";

        format-disconnected = "  disconnected";
        format-disconnected-background = "#f38ba8";
        format-disconnected-foreground = "#1e1e2e";
        format-disconnected-padding = 2;
      };

      "module/filesystem" = {
        type = "internal/fs";
        mount-0 = "/";

        format-mounted = "  <label-mounted>";
        format-mounted-background = "#313244";
        format-mounted-padding = 2;
        label-mounted = "%percentage_used%%";
      };
    };
  };

  # Picom compositor configuration (for transparency and effects)
  services.picom = {
    enable = true;

    # Fading
    fade = true;
    fadeDelta = 8;
    fadeSteps = [ 0.028 0.03 ];

    # Shadows
    shadow = true;
    shadowOpacity = 0.6;
    shadowRadius = 12;
    shadowOffsets = [ (-7) (-7) ];
    shadowExclude = [
      "class_g = 'i3-frame'"
      "class_g ?= 'Notify-osd'"
      "class_g = 'Cairo-clock'"
    ];

    # Transparency/Opacity
    activeOpacity = 1.0;
    inactiveOpacity = 0.95;
    menuOpacity = 0.9;

    # Background blurring (optional - can be performance intensive)
    blur = {
      method = "gaussian";
      size = 10;
      deviation = 5.0;
    };

    # Rounded corners
    cornerRadius = 8;
    roundedCornersExclude = [
      "window_type = 'dock'"
      "window_type = 'desktop'"
    ];

    # Other settings
    backend = "glx";
    vsync = true;
    markWmwinFocused = true;
    markOvrdrWmwin = true;
    detectRounded = true;
    detectClient = true;
    refreshRate = 0;
    unredir = false;

    # Window type settings
    wintypes = {
      tooltip = { fade = true; shadow = true; opacity = 0.75; focus = true; };
      dock = { shadow = false; };
      dnd = { shadow = false; };
      popup_menu = { opacity = 0.9; };
      dropdown_menu = { opacity = 0.9; };
    };
  };
}
