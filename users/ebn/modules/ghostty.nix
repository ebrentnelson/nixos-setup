{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      # Basic colors
      background = "#111111";
      foreground = "#f9f9f9";

      # Cursor
      cursor-color = "#fe386e";

      # Selection
      selection-background = "#fe386e";
      selection-foreground = "#ffffff";

      # Appearance
      background-opacity = "0.95";
      font-family = "GeistMono Nerd Font";
      font-size = 12;
      window-decoration = false;

      # Keybindings
      keybind = [
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
      ];
    };
  };
}
