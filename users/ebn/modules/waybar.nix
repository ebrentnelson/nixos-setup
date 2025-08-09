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
        font-size: 16px;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background: linear-gradient(90deg, rgba(51, 204, 255, 0.9) 0%, rgba(0, 255, 153, 0.9) 100%);
        color: #1e1e2e;
        border: none;
        border-radius: 0;
        padding: 8px 12px;
        backdrop-filter: blur(10px);
      }

      #workspaces {
        background: transparent;
        margin: 0;
        padding: 0;
      }

      #workspaces button {
        background: transparent;
        color: #1e1e2e;
        border: none;
        border-radius: 6px;
        margin: 4px 2px;
        padding: 4px 8px;
        font-weight: bold;
        font-size: 16px;
        transition: all 0.3s ease;
      }

      #workspaces button.active {
        background: rgba(30, 30, 46, 0.3);
        color: #1e1e2e;
        box-shadow: inset 0 2px 4px rgba(0,0,0,0.2);
      }

      #workspaces button:hover {
        background: rgba(30, 30, 46, 0.2);
        transform: scale(1.05);
      }

      #clock, #network, #pulseaudio, #battery, #tray, #custom-power {
        background: rgba(30, 30, 46, 0.15);
        color: #1e1e2e;
        border-radius: 6px;
        padding: 6px 12px;
        margin: 4px 2px;
        font-weight: bold;
        backdrop-filter: blur(5px);
        border: 1px solid rgba(255,255,255,0.1);
        transition: all 0.3s ease;
      }

      #clock:hover, #network:hover, #pulseaudio:hover, #battery:hover, #custom-power:hover {
        background: rgba(30, 30, 46, 0.25);
        transform: translateY(-1px);
      }

      #battery.warning {
        background: rgba(251, 183, 135, 0.8);
        color: #1e1e2e;
        animation: pulse 2s infinite;
      }

      #battery.critical {
        background: rgba(243, 139, 168, 0.8);
        color: #1e1e2e;
        animation: blink 0.5s linear infinite alternate;
      }

      @keyframes blink {
        to { 
          background-color: rgba(243, 139, 168, 0.3); 
          transform: scale(1.02);
        }
      }

      @keyframes pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.8; }
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: rgba(243, 139, 168, 0.3);
      }
    '';
  };
}
