{ config, pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./neovim.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage
  home.username = "ebn";
  home.homeDirectory = "/home/ebn";

  # This value determines the Home Manager release which your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "24.05";

  # Additional Home Manager packages (things you want in your user environment)
  home.packages = with pkgs; [
    # Add any user-specific packages here
    # For example: personal scripts, user-only tools, etc.
  ];

  # Git configuration (optional - you can configure this here)
  programs.git = {
    enable = true;
    userName = "E Brent Nelson";
    userEmail = "ebrentnelson@gmail.com"; # Replace with your email
  };

  # Zsh configuration (since you use zsh as your shell)
  programs.zsh = {
    enable = true;
    # Add any zsh-specific configuration here
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}