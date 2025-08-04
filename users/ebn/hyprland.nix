{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      debug = {
        suppress_errors = true;
      };

      # Monitor configuration
      monitor = [
        ",preferred,auto,auto"
        ",1920x1080@60,auto,1"
        ",auto,auto,1"
      ];

      # Execute your favorite apps at launch
      exec-once = [
        "waybar"
        "mako"
        "nm-applet --indicator"
        "dropbox start"
      ];

      # Environment variables
      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];

      # Input configuration
      input = {
          kb_layout = "us";
          follow_mouse = 1;
          touchpad = {
            natural_scroll = "no";
          };
          sensitivity = 0;
      };

      # General configuration
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };

      # Decoration
      decoration = {
        rounding = 5;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      # Animations
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Window rules
      windowrule = [
        "float, ^(pavucontrol)$"
        "float, ^(nm-connection-editor)$"
      ];

      # Key bindings
      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$browser" = "MOZ_ENABLE_WAYLAND=1 firefox --new-window";

      # Basic bindings
      bind = [
        # Close window
        "$mainMod, W, killactive,"

        # Control tiling
        "$mainMod, J, togglesplit,"
        "$mainMod, P, pseudo,"
        "$mainMod, V, togglefloating,"
        
        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Swap active window with the one next to it with mainMod + SHIFT + arrow keys
        "$mainMod SHIFT, left, Swap window to the left, swapwindow, l"
        "$mainMod SHIFT, right, Swap window to the right, swapwindow, r"
        "$mainMod SHIFT, up, Swap window up, swapwindow, u"
        "$mainMod SHIFT, down, Swap window down, swapwindow, d"


        # Cycle through applications on active workspace
        "ALT, Tab, Cycle to next window, cyclenext"
        "ALT, Tab, Reveal active window on top, bringactivetotop"

        # Resize active window
        "$mainMod, minus, Expand window left, resizeactive, -100 0"
        "$mainMod, equal, Shrink window left, resizeactive, 100 0"
        "$mainMod SHIFT, minus, Shrink window up, resizeactive, 0 -100"
        "$mainMod SHIFT, equal, Expand window down, resizeactive, 0 100"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, Scroll active worspace forward, workspace, e+1"
        "$mainMod, mouse_up, Scroll active workspace backward, workspace, e-1"

        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, Move window, movewindow"
        "$mainMod, mouse:273, Resize window, resizewindow"

        # Workspace love
        "CTRL, left, workspace, e-1"
        "CTRL, right, workspace, e+1"
        "CTRL_SHIFT, left, movetoworkspace, e-1"
        "CTRL_SHIFT, right, movetoworkspace, e+1"

        # Screenshots
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "SHIFT, Print, exec, grim - | wl-copy"

        # Audio controls
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # Brightness controls (for laptops)
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"


        # Application bindings
        "$mainMod, return, Terminal,     exec, kitty"
        "$mainMod, F,      File Manager, exec, thunar"
        "$mainMod, B,      Browser,      exec, $browser"
        "$mainMod, space,  Launch apps,  exec, wofi --show drun"
        "$mainMod, M,      Music,        exec, spotify"
        "$mainMod, N,      Neovim,       exec, $terminal -e nvim"
        "$mainMod, O,      Obsidian,     exec, obsidian"

        # Web app bindings
        "$mainMod, A,       Claude,          exec, $browser \"https://claude.ai/\""
        "$mainMod, E,       Email,           exec, $browser \"https://mail.google.com/\""
        "$mainMod, C,       Calendar,        exec, $browser \"https://calendar.google.com/\""
        "$mainMod SHIFT, G, WhatsApp,        exec, $browser \"https://web.whatsapp.com/\""
        "$mainMod ALT, G,   Google Messages, exec, $browser \"https://messages.google.com/web/conversations/\""
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };
}
