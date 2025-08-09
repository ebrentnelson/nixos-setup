{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    font = "GeistMono Nerd Font 14";
    theme = {
      "*" = {
        bg-col = "#1e1e2e";
        bg-col-light = "#1e1e2e";
        border-col = "#a6e3a1";
        selected-col = "#a6e3a1";
        blue = "#89b4fa";
        fg-col = "#cdd6f4";
        fg-col2 = "#f38ba8";
        grey = "#6c7086";
        width = 600;
        font = "GeistMono Nerd Font 14";
      };

      "element-text, element-icon, mode-switcher" = {
        background-color = "inherit";
        text-color = "inherit";
      };

      "window" = {
        height = "400px";
        border = "2px";
        border-color = "@border-col";
        border-radius = "8px";
        background-color = "rgba(30, 30, 46, 95%)";
      };

      "mainbox" = {
        background-color = "@bg-col";
      };

      "inputbar" = {
        children = "[ prompt, entry ]";
        background-color = "@bg-col";
        border-radius = "6px";
        padding = "8px 12px";
        margin = "10px";
        border = "2px";
        border-color = "#45475a";
      };

      "prompt" = {
        background-color = "transparent";
        text-color = "@fg-col";
        margin = "0px 8px 0px 0px";
      };

      "textbox-prompt-colon" = {
        expand = false;
        str = ":";
        text-color = "@fg-col";
      };

      "entry" = {
        background-color = "transparent";
        text-color = "@fg-col";
        placeholder-color = "@grey";
        placeholder = "Search...";
      };

      "listview" = {
        border = "0px 0px 0px 0px";
        padding = "6px 0px 0px 0px";
        margin = "10px 10px 0px 10px";
        columns = 1;
        lines = 8;
        background-color = "@bg-col";
      };

      "element" = {
        padding = "8px 12px";
        margin = "2px";
        border-radius = "4px";
        background-color = "transparent";
        text-color = "@fg-col";
      };

      "element-icon" = {
        size = "32px";
        margin = "0px 10px 0px 0px";
      };

      "element selected" = {
        background-color = "rgba(166, 227, 161, 10%)";
        border = "1px";
        border-color = "@selected-col";
        text-color = "@fg-col";
      };

      "mode-switcher" = {
        spacing = 0;
      };

      "button" = {
        padding = "10px";
        background-color = "@bg-col-light";
        text-color = "@grey";
        vertical-align = "0.5";
        horizontal-align = "0.5";
      };

      "button selected" = {
        background-color = "@bg-col";
        text-color = "@blue";
      };

      "message" = {
        background-color = "@bg-col-light";
        margin = "2px";
        padding = "2px";
        border-radius = "5px";
      };

      "textbox" = {
        padding = "6px";
        margin = "20px 0px 0px 20px";
        text-color = "@blue";
        background-color = "@bg-col-light";
      };
    };
  };
}
