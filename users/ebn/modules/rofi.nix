{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    font = "GeistMono Nerd Font 14";
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      drun-display-format = "{name}";
      display-drun = "Apps:";
      disable-history = false;
      hide-scrollbar = true;
      sidebar-mode = false;
    };
  };

  # Create custom theme file
  home.file.".config/rofi/theme.rasi".text = ''
    * {
        bg-col:         #111111;
        bg-alt:         #1a1a1a;
        border-col:     #333333;
        selected-col:   #fe386e;
        fg-col:         #f9f9f9;
        fg-col2:        #888888;
        urgent-col:     #fe386e;
        width:          600;
        font:           "GeistMono Nerd Font 14";
    }
    
    element-text, element-icon, mode-switcher {
        background-color: inherit;
        text-color:       inherit;
    }
    
    window {
        height: 400px;
        border: 2px;
        border-color: @border-col;
        border-radius: 0px;
        background-color: @bg-col;
    }
    
    mainbox {
        background-color: @bg-col;
    }
    
    inputbar {
        children: [prompt,entry];
        background-color: @bg-alt;
        border-radius: 0px;
        padding: 12px 16px;
        margin: 0px;
        border-bottom: 2px;
        border-color: @border-col;
    }
    
    prompt {
        background-color: transparent;
        text-color: @selected-col;
        margin: 0px 12px 0px 0px;
        font-weight: bold;
    }
    
    entry {
        background-color: transparent;
        text-color: @fg-col;
        placeholder-color: @fg-col2;
        placeholder: "Search...";
    }
    
    listview {
        border: 0px;
        padding: 8px 0px 0px;
        margin: 0px;
        columns: 1;
        lines: 8;
        background-color: @bg-col;
    }
    
    element {
        padding: 12px 16px;
        margin: 0px;
        border-radius: 0px;
        background-color: transparent;
        text-color: @fg-col;
    }
    
    element-icon {
        size: 24px;
        margin: 0px 12px 0px 0px;
    }
    
    element selected {
        background-color: @bg-alt;
        border-left: 4px;
        border-left-color: @selected-col;
        text-color: @fg-col;
    }
    
    element selected.urgent {
        background-color: @urgent-col;
        text-color: @bg-col;
    }
  '';
}
