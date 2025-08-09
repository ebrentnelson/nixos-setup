{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 50;
        spacing = 4;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "network" "pulseaudio" "battery" "custom/power" ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "●";
            default = "○";
          };
          on-click = "activate";
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d %H:%M:%S}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };

        network = {
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰈀 Connected";
          format-disconnected = "󰤭 Disconnected";
          tooltip-format = "{ifname}: {ipaddr}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 Muted";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "pavucontrol";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          format-charging = "󰂄 {capacity}%";
        };

        tray = {
          spacing = 10;
          icon-size = 20;
        };

        "custom/power" = {
          format = "󰐥";
          tooltip = "Power Menu";
          on-click = "wlogout";
        };
      };
    };

    style = ''
      * {
        font-family: "GeistMono Nerd Font";
        font-size: 18px;
        min-height: 0;
      }

      window#waybar {
        background: linear-gradient(90deg, #33ccff 0%, #00ff99 100%);
        color: #1e1e2e;
        border: none;
        border-radius: 0;
        padding: 10px;
      }

      #workspaces button {
        background: transparent;
        color: #1e1e2e;
        border: none;
        border-radius: 8px;
        margin: 8px;
        padding: 8px 12px;
        font-weight: bold;
        font-size: 18px;
      }

      #workspaces button.active {
        background: rgba(30, 30, 46, 0.3);
        color: #1e1e2e;
      }

      #workspaces button:hover {
        background: rgba(30, 30, 46, 0.2);
      }

      #clock, #network, #pulseaudio, #battery, #tray, #custom-power {
        background: rgba(30, 30, 46, 0.1);
        color: #1e1e2e;
        border-radius: 8px;
        padding: 8px 15px;
        margin: 8px;
        font-weight: bold;
      }

      #battery.warning {
        background: rgba(251, 183, 135, 0.8);
        color: #1e1e2e;
      }

      #battery.critical {
        background: rgba(243, 139, 168, 0.8);
        color: #1e1e2e;
        animation: blink 0.5s linear infinite alternate;
      }

      @keyframes blink {
        to { background-color: rgba(243, 139, 168, 0.3); }
      }
    '';
  };
}
