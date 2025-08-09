{ config, pkgs, ... }:

{
  services.mako = {
  enable = true;
  
  settings = {
    # Basic appearance
    background-color = "#1e1e2e";
    text-color = "#cdd6f4";
    border-color = "#a6e3a1";
    progress-color = "over #313244";
    
    # Dimensions
    width = 350;
    height = 100;
    padding = "15";
    margin = "10";
    border-radius = 8;
    border-size = 2;
    
    # Font
    font = "GeistMono Nerd Font 12";
    
    # Timing
    default-timeout = 5000;
    ignore-timeout = true;
    
    # Position
    anchor = "top-right";
    
    # Icons
    icons = true;
    icon-path = "${pkgs.adwaita-icon-theme}/share/icons/Adwaita";
    max-icon-size = 48;
    
    # Grouping and actions
    group-by = "app-name";
    actions = true;
    format = "<b>%s</b>\\n%b";
    layer = "overlay";
    
    # Urgency-specific settings
    "urgency=critical" = {
      background-color = "#f38ba8";
      text-color = "#1e1e2e";
      border-color = "#f38ba8";
      default-timeout = 0;
    };
    
    "urgency=high" = {
      background-color = "#fab387";
      text-color = "#1e1e2e";
      border-color = "#fab387";
      default-timeout = 8000;
    };
    
    "app-name=\"Spotify\"" = {
      border-color = "#a6e3a1";
      background-color = "#181825";
    };
  };
};
}
