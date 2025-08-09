{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#a6e3a1";
    progressColor = "over #313244";
    
    width = 350;
    height = 100;
    padding = "15";
    margin = "10";
    borderRadius = 8;
    borderSize = 2;
    
    font = "GeistMono Nerd Font 12";
    
    defaultTimeout = 5000;
    ignoreTimeout = true;
    
    # Position
    anchor = "top-right";
    
    # Icons
    icons = true;
    iconPath = "${pkgs.adwaita-icon-theme}/share/icons/Adwaita";
    maxIconSize = 48;
    
    # Grouping
    groupBy = "app-name";
    
    # Actions
    actions = true;
    
    # Format
    format = "<b>%s</b>\\n%b";
    
    # Layer (for Hyprland)
    layer = "overlay";
    
    extraConfig = ''
      [urgency=critical]
      background-color=#f38ba8
      text-color=#1e1e2e
      border-color=#f38ba8
      default-timeout=0
      
      [urgency=high]
      background-color=#fab387
      text-color=#1e1e2e
      border-color=#fab387
      default-timeout=8000
      
      [app-name="Spotify"]
      border-color=#a6e3a1
      background-color=#181825
    '';
  };
}
