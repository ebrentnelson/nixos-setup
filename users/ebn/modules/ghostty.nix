{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      background-opacity = "0.95";  
      font-family = "GeistMono Nerd Font";
      font-size = 12;
      window-decoration = false;
      
      keybind = [
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
      ];
    };
  };
}
