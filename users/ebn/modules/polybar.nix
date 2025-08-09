{ config, pkgs, ... }:

# Polybar configuration (replaces waybar)
services.polybar = {
  enable = true;
  script = "polybar main &";
  config = {
    "bar/main" = {
      width = "100%";
      height = 50;
      background = "#33ccff";
      foreground = "#1e1e2e";
      
      modules-left = "i3";
      modules-center = "date";
      modules-right = "tray filesystem pulseaudio battery powermenu";
      
      font-0 = "GeistMono Nerd Font:size=13;2";
      font-1 = "GeistMono Nerd Font:size=18;3";  # For bigger icons
      
      tray-position = "right";
      tray-padding = 4;
      tray-spacing = 8;
    };
    
    "module/i3" = {
      type = "internal/i3";
      format = "<label-state>";
      
      label-focused = "●";
      label-focused-background = "rgba(30, 30, 46, 0.3)";
      label-focused-foreground = "#1e1e2e";
      label-focused-padding = 2;
      label-focused-font = 2;
      
      label-unfocused = "○";
      label-unfocused-padding = 2;
      label-unfocused-font = 2;
      
      label-visible = "○";
      label-visible-padding = 2;
      label-visible-font = 2;
    };
    
    "module/date" = {
      type = "internal/date";
      interval = 1;
      date = "%H:%M";
      date-alt = "%Y-%m-%d %H:%M:%S";
      label = "%date%";
      font = 1;
    };
    
    "module/filesystem" = {
      type = "internal/fs";
      mount-0 = "/";
      format-mounted = "<ramp-capacity> <label-mounted>";
      label-mounted = "%percentage_used%%";
      ramp-capacity-0 = "󰋊";
      ramp-capacity-font = 2;
    };
    
    "module/pulseaudio" = {
      type = "internal/pulseaudio";
      format-volume = "<ramp-volume> <label-volume>";
      label-muted = "%{T2}󰝟%{T-} Muted";
      ramp-volume-0 = "%{T2}󰕿%{T-}";
      ramp-volume-1 = "%{T2}󰖀%{T-}";
      ramp-volume-2 = "%{T2}󰕾%{T-}";
      click-right = "pavucontrol";
    };
    
    "module/battery" = {
      type = "internal/battery";
      battery = "BAT0";
      adapter = "ADP1";
      format-charging = "%{T2}󰂄%{T-} <label-charging>";
      format-discharging = "<ramp-capacity> <label-discharging>";
      label-charging = "%percentage%%";
      label-discharging = "%percentage%%";
      ramp-capacity-0 = "%{T2}󰂎%{T-}";
      ramp-capacity-1 = "%{T2}󰁺%{T-}";
      ramp-capacity-2 = "%{T2}󰁿%{T-}";
      ramp-capacity-3 = "%{T2}󰂀%{T-}";
      ramp-capacity-4 = "%{T2}󰁹%{T-}";
    };
    
    "module/powermenu" = {
      type = "custom/menu";
      expand-right = true;
      format-spacing = 1;
      
      label-open = "%{T2}󰐥%{T-}";
      label-open-foreground = "#1e1e2e";
      label-close = "%{T2}󰅖%{T-}";
      label-close-foreground = "#1e1e2e";
      
      menu-0-0 = "%{T2}󰜉%{T-}";
      menu-0-0-exec = "systemctl reboot";
      menu-0-1 = "%{T2}󰐥%{T-}";  
      menu-0-1-exec = "systemctl poweroff";
      menu-0-2 = "%{T2}󰍃%{T-}";
      menu-0-2-exec = "i3-msg exit";
    };
  };
};
