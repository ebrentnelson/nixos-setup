{ config, pkgs, ... }:

{
  dconf.enable = false;
  
  gtk = {
    enable = true;
    
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
    
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "blue";
      };
    };
    
    font = {
      name = "GeistMono Nerd Font";
      size = 11;
    };
    
    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme=1
    '';
    
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  
  # Custom CSS for Thunar and other GTK apps
  home.file.".config/gtk-3.0/gtk.css".text = ''
    /* Thunar sidebar styling */
    .thunar .sidebar .view,
    .thunar .sidebar iconview {
      background-color: #1e1e2e;
      color: #cdd6f4;
      border-radius: 4px;
    }
    
    .thunar .sidebar .view:selected,
    .thunar .sidebar iconview:selected,
    .thunar .sidebar .view:active,
    .thunar .sidebar iconview:active {
      background-color: rgba(166, 227, 161, 0.2);
      color: #cdd6f4;
    }
    
    /* Main area background */
    .thunar .view,
    .thunar iconview {
      background-color: #181825;
      color: #cdd6f4;
    }
    
    .thunar .view:selected,
    .thunar iconview:selected {
      background-color: rgba(166, 227, 161, 0.3);
      color: #11111b;
    }
    
    /* Toolbar styling */
    .thunar toolbar {
      background-color: #1e1e2e;
      border-bottom: 1px solid #45475a;
    }
    
    /* Path bar */
    .thunar .path-bar button {
      background-color: #313244;
      color: #cdd6f4;
      border: 1px solid #45475a;
      border-radius: 4px;
      margin: 2px;
    }
    
    .thunar .path-bar button:hover {
      background-color: #45475a;
    }
    
    .thunar .path-bar button:active {
      background-color: rgba(166, 227, 161, 0.2);
    }
  '';
  
  # GTK4 extra CSS (handled through gtk.gtk4.extraCss instead of home.file)
  gtk.gtk4.extraCss = ''
    /* Thunar styling for GTK4 */
    .thunar .sidebar .view,
    .thunar .sidebar iconview {
      background-color: #1e1e2e;
      color: #cdd6f4;
    }
    
    .thunar .sidebar .view:selected,
    .thunar .sidebar iconview:selected {
      background-color: rgba(166, 227, 161, 0.2);
      color: #cdd6f4;
    }
  '';
}
