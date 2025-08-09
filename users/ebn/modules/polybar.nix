{ config, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    script = "polybar main &";
    config = {
      "bar/main" = {
        width = "100%";
        height = 50;
        background = "#111111";
        foreground = "#f9f9f9";

        modules-left = "xworkspaces";
        modules-center = "date";
        modules-right = "network alsa powermenu";

        font-0 = "GeistMono Nerd Font:size=13;2";

        tray-position = "right";
        tray-spacing = 8;
        tray-padding = 4;
        tray-background = "#1a1a1a";

        module-margin-left = 1;  
        module-margin-right = 1;

        border-top-size = 2;
        border-top-color = "#333333";
      };

      "module/xworkspaces" = {
        type = "internal/xworkspaces";
        label-active = "●";
        label-active-padding = 1;
        label-active-foreground = "#fe386e";
        label-occupied = "○";
        label-occupied-padding = 1;
        label-occupied-foreground = "#888888";
        label-empty = "";
      };

      "module/date" = {
        type = "internal/date";
        date = "%H:%M";
        format-foreground = "#f9f9f9";
      };

      "module/network" = {
        type = "internal/network";
        interface-type = "wireless";
        format-connected = " 󰤨 <label-connected> ";
        format-connected-foreground = "#f9f9f9";
        format-disconnected = " 󰤭 Disconnected ";
        format-disconnected-foreground = "#666666";
        label-connected = "%signal%%";
      };

      "module/alsa" = {
        type = "internal/alsa";
        format-volume = " <ramp-volume> <label-volume> ";
        format-volume-foreground = "#f9f9f9";
        format-muted = " 󰝟 Muted ";
        format-muted-foreground = "#666666";
        ramp-volume-0 = "󰕿";
        ramp-volume-1 = "󰖀";
        ramp-volume-2 = "󰕾";
        click-right = "pavucontrol";
      };

      "module/powermenu" = {
        type = "custom/text";
        content = " 󰐥 ";
        content-foreground = "#fe386e";
        click-left = "rofi -show p -modi p:rofi-power-menu -theme ~/.config/rofi/theme.rasi";
      };
    };
  };
}
