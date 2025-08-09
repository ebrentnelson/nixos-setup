{ config, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    script = "polybar main &";
    config = {
      "bar/main" = {
        width = "100%";
        height = 50;
        background = "#1ae5cc";
        foreground = "#1e1e2e";

        modules-left = "xworkspaces";
        modules-center = "date";
        modules-right = "tray network pulseaudio powermenu";

        font-0 = "GeistMono Nerd Font:size=13;2";

        tray-position = "right";
        tray-spacing = 8;
        tray-padding = 4;

        module-margin-left = 1;  
        module-margin-right = 1;
      };

      "module/xworkspaces" = {
        type = "internal/xworkspaces";
        label-active = "●";
        label-active-padding = 1;
        label-occupied = "○";
        label-occupied-padding = 1;
        label-empty = "";
      };

      "module/date" = {
        type = "internal/date";
        date = "%H:%M";
      };

      "module/network" = {
        type = "internal/network";
        interface-type = "wireless";
        format-connected = " 󰤨 <label-connected> ";
        format-disconnected = " 󰤭 Disconnected ";
        label-connected = "%signal%%";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        format-volume = " <ramp-volume> <label-volume> ";
        format-muted = " 󰝟 Muted ";
        ramp-volume-0 = "󰕿";
        ramp-volume-1 = "󰖀";
        ramp-volume-2 = "󰕾";
        click-right = "pavucontrol";
        use-ui-max = false;
      };

      "module/powermenu" = {
        type = "custom/text";
        content = " 󰐥 ";
        click-left = "rofi -show p -modi p:rofi-power-menu -theme ~/.config/rofi/theme.rasi";
      };
    };
  };
}
