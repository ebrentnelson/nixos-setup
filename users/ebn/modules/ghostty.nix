{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      background-opacity = "0.95";  
      font-family = "GeistMono Nerd Font";
      font-size = 12;
      window-decoration = false;
      
      # Theme
      theme = "gruvbox-dark";
      
      # Keybindings that work across platforms
      keybind = [
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
      ];
    };
  };
}
