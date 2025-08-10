{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;

    settings = {
      # Basic appearance
      background-color = "#111111";
      text-color = "#f9f9f9";
      border-color = "#333333";
      progress-color = "over #fe386e";

      # Dimensions
      width = 350;
      height = 100;
      padding = "16";
      margin = "10";
      border-radius = 0;
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
      max-icon-size = 32;

      # Grouping and actions
      group-by = "app-name";
      actions = true;
      format = "<b>%s</b>\\n%b";
      layer = "overlay";

      # Urgency-specific settings
      "urgency=low" = {
        background-color = "#111111";
        text-color = "#888888";
        border-color = "#333333";
        default-timeout = 4000;
      };

      "urgency=normal" = {
        background-color = "#111111";
        text-color = "#f9f9f9";
        border-color = "#333333";
        default-timeout = 6000;
      };

      "urgency=critical" = {
        background-color = "#fe386e";
        text-color = "#ffffff";
        border-color = "#fe386e";
        default-timeout = 0;
      };

      # App-specific rules
      "app-name=Spotify" = {
        border-color = "#fe386e";
        background-color = "#1a1a1a";
        text-color = "#f9f9f9";
      };

      "app-name=Volume" = {
        border-color = "#666666";
        background-color = "#1a1a1a";
      };
    };
  };
}
