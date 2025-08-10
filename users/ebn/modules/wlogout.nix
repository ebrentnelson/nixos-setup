{ config, pkgs, ... }:

{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    style = ''
      * {
        background-image: none;
        font-family: "GeistMono Nerd Font";
        font-size: 16px;
        color: #f9f9f9;
      }
      
      window {
        background-color: rgba(17, 17, 17, 0.95);
      }
      
      button {
        color: #f9f9f9;
        background-color: #1a1a1a;
        border-style: solid;
        border-width: 2px;
        border-radius: 0px;
        border-color: #333333;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 20%;
        margin: 12px;
        padding: 20px;
        transition: all 0.3s ease;
      }
      
      button:focus, button:active {
        background-color: #222222;
        border-color: #fe386e;
        outline-style: none;
      }
      
      button:hover {
        background-color: #222222;
        border-color: #fe386e;
        color: #fe386e;
      }
      
      #lock {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
      }
      
      #logout {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
      }
      
      #suspend {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
      }
      
      #hibernate {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
      }
      
      #shutdown {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
      }
      
      #reboot {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
      }
    '';
  };
}
