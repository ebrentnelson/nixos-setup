# Add this new module: users/ebn/modules/wofi.nix
{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };
    
    style = ''
      window {
        margin: 0px;
        border: 2px solid #a6e3a1;
        border-radius: 8px;
        background-color: rgba(30, 30, 46, 0.95);
        font-family: "GeistMono Nerd Font";
        font-size: 14px;
      }

      #input {
        margin: 10px;
        border: 2px solid #45475a;
        border-radius: 6px;
        background-color: #1e1e2e;
        color: #cdd6f4;
        padding: 8px 12px;
      }

      #input:focus {
        border-color: #a6e3a1;
        outline: none;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: transparent;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: transparent;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: #cdd6f4;
      }

      #entry {
        border: none;
        border-radius: 4px;
        background-color: transparent;
        margin: 2px;
        padding: 8px 12px;
      }

      #entry:selected {
        background-color: rgba(166, 227, 161, 0.1);
        border: 1px solid #a6e3a1;
      }

      #entry:hover {
        background-color: rgba(166, 227, 161, 0.05);
      }
    '';
  };
}
