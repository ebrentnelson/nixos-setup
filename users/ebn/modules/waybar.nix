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
      border-radius: 0px;
    }
  
    window#waybar {
      background: #111111;
      color: #f9f9f9;
      border-top: 2px solid #333333;
    }
  
    #workspaces {
      background: transparent;
      margin: 4px 8px;
    }
  
    #workspaces button {
      background: transparent;
      color: #888888;
      border: none;
      padding: 8px 12px;
      margin: 0px 2px;
      font-weight: bold;
      transition: all 0.2s ease;
    }
  
    #workspaces button.active {
      background: #1a1a1a;
      color: #fe386e;
      border-bottom: 2px solid #fe386e;
    }
  
    #workspaces button:hover {
      background: #222222;
      color: #f9f9f9;
    }
  
    #clock {
      background: #1a1a1a;
      color: #f9f9f9;
      padding: 8px 16px;
      margin: 4px;
      font-weight: bold;
    }
  
    #network, #pulseaudio, #battery {
      background: #1a1a1a;
      color: #f9f9f9;
      padding: 8px 12px;
      margin: 4px 2px;
      border-left: 2px solid #333333;
    }
  
    #network.disconnected {
      color: #666666;
    }
  
    #pulseaudio.muted {
      color: #666666;
    }
  
    #battery.warning {
      color: #cccccc;
      border-left-color: #cccccc;
    }
  
    #battery.critical {
      color: #fe386e;
      border-left-color: #fe386e;
      animation: blink 1s ease-in-out infinite alternate;
    }
  
    @keyframes blink {
      to { 
        background-color: rgba(254, 56, 110, 0.1);
      }
    }
  
    #tray {
      background: #1a1a1a;
      padding: 4px 8px;
      margin: 4px;
    }
  
    #tray > .passive {
      -gtk-icon-effect: dim;
    }
  
    #tray > .needs-attention {
      -gtk-icon-effect: highlight;
      background-color: rgba(254, 56, 110, 0.2);
    }
  
    #custom-power {
      background: #1a1a1a;
      color: #fe386e;
      padding: 8px 12px;
      margin: 4px;
      font-weight: bold;
      border-left: 2px solid #fe386e;
    }
  
    #custom-power:hover {
      background: rgba(254, 56, 110, 0.1);
    }
  '';
  };
}
