{ config, pkgs, ... }:

{
 services.polybar = {
   enable = true;
   script = "polybar main &";
   config = {
     "bar/main" = {
       width = "100%";
       height = 50;
       background = "#33ccff";
       foreground = "#1e1e2e";
       
       modules-left = "xworkspaces";
       modules-center = "date";
       modules-right = "pulseaudio tray powermenu";
       
       font-0 = "GeistMono Nerd Font:size=13;2";
       
       tray-position = "right";
       tray-spacing = 8;
       tray-padding = 4;
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
     
     "module/pulseaudio" = {
       type = "internal/pulseaudio";
       format-volume = "🔊 <label-volume>";
       format-muted = "🔇 Muted";
       click-right = "pavucontrol";
     };
     
     "module/powermenu" = {
       type = "custom/text";
       content = " ⏻ ";
       click-left = "rofi -show p -modi p:rofi-power-menu";
     };
   };
 };
}
