{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./neovim.nix
    ./starship.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "ebn";
  home.homeDirectory = "/home/ebn";

  # This value determines the Home Manager release which your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "25.05";

  # Additional Home Manager packages (things you want in your user environment)
  home.packages = with pkgs; [
    # Add any user-specific packages here
    # For example: personal scripts, user-only tools, etc.
  ];

  # Git configuration (optional - you can configure this here)
  programs.git = {
    enable = true;
    userName = "FIXME";
    userEmail = "FIXME"; # Replace with your email
  };

  # Zsh configuration (since you use zsh as your shell)
  programs.zsh = {
    enable = true;
    # Add any zsh-specific configuration here
  };

  programs.mako = {
    enable = true;
    settings = {
      defaultTimeout = 5000;
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "OpenDyslexic Nerd Font";
      size = 12;
    };
    settings = {
      background_opacity = "0.85";  # 0.0 = fully transparent, 1.0 = fully opaque
      dynamic_background_opacity = true;  # Allows changing opacity with Ctrl+Shift+A/L
    };
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
