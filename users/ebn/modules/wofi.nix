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
        border: 2px solid #333333;
        border-radius: 0px;
        background-color: #111111;
        font-family: "GeistMono Nerd Font";
        font-size: 14px;
      }
    
      #input {
        margin: 0px;
        border: none;
        border-bottom: 2px solid #333333;
        border-radius: 0px;
        background-color: #1a1a1a;
        color: #f9f9f9;
        padding: 12px 16px;
        font-size: 14px;
      }
    
      #input:focus {
        border-bottom-color: #fe386e;
        outline: none;
      }
    
      #inner-box {
        margin: 0px;
        border: none;
        background-color: transparent;
      }
    
      #outer-box {
        margin: 0px;
        border: none;
        background-color: transparent;
      }
    
      #scroll {
        margin: 0px;
        border: none;
      }
    
      #text {
        margin: 0px;
        border: none;
        color: #f9f9f9;
        font-weight: normal;
      }
    
      #entry {
        border: none;
        border-radius: 0px;
        background-color: transparent;
        margin: 0px;
        padding: 12px 16px;
        color: #f9f9f9;
      }
    
      #entry:selected {
        background-color: #1a1a1a;
        border-left: 4px solid #fe386e;
      }
    
      #entry:hover {
        background-color: #222222;
      }
    
      #entry:selected #text {
        color: #f9f9f9;
      }
    
      #entry image {
        margin-right: 12px;
      }
    '';
  };
}
