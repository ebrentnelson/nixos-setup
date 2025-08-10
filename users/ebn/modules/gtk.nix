{ config, pkgs, ... }:

{
  dconf.enable = false;
  
  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
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
    /* Global dark theme overrides */
    window {
      background-color: #111111;
      color: #f9f9f9;
    }
    
    /* Thunar sidebar styling */
    .thunar .sidebar .view,
    .thunar .sidebar iconview {
      background-color: #1a1a1a;
      color: #f9f9f9;
      border-radius: 0px;
    }
    
    .thunar .sidebar .view:selected,
    .thunar .sidebar iconview:selected,
    .thunar .sidebar .view:active,
    .thunar .sidebar iconview:active {
      background-color: #fe386e;
      color: #ffffff;
    }
    
    /* Main area background */
    .thunar .view,
    .thunar iconview {
      background-color: #111111;
      color: #f9f9f9;
    }
    
    .thunar .view:selected,
    .thunar iconview:selected {
      background-color: #fe386e;
      color: #ffffff;
    }
    
    /* Toolbar styling */
    .thunar toolbar {
      background-color: #1a1a1a;
      border-bottom: 1px solid #333333;
    }
    
    /* Path bar */
    .thunar .path-bar button {
      background-color: #333333;
      color: #f9f9f9;
      border: 1px solid #555555;
      border-radius: 0px;
      margin: 2px;
    }
    
    .thunar .path-bar button:hover {
      background-color: #fe386e;
      color: #ffffff;
    }
    
    /* Button accents */
    button:hover {
      background-color: #fe386e;
      color: #ffffff;
    }
  '';
  
  # GTK4 extra CSS
  gtk.gtk4.extraCss = ''
    window {
      background-color: #111111;
      color: #f9f9f9;
    }
    
    .thunar .sidebar .view:selected {
      background-color: #fe386e;
      color: #ffffff;
    }
  '';
}
