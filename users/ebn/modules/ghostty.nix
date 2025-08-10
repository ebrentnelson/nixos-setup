{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      theme = "retrosquare";
      # Appearance
      background-opacity = 0.95;
      font-family = "GeistMono Nerd Font";
      font-size = 12;
      window-decoration = false;

      # Keybindings
      keybind = [
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
      ];
    };
    themes = {
      retrosquare = {
        background = "111111";
        cursor-color = "fe386e";
        foreground = "f9f9f9";
        palette = [
          "0=#111111"
          "1=#fe386e"
          "2=#888888"
          "3=#cccccc"
          "4=#666666"
          "5=#fe386e"
          "6=#aaaaaa"
          "7=#f9f9f9"
          "8=#333333"
          "9=#fe386e"
          "10=#aaaaaa"
          "11=#f9f9f9"
          "12=#888888"
          "13=#fe386e"
          "14=#cccccc"
          "15=#ffffff"
        ];
        selection-background = "fe386e";
        selection-foreground = "ffffff";
      };
    };
  };
}
