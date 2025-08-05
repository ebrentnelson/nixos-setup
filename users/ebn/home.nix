{ config, pkgs, ... }:

{
  imports = [
    # Remove hyprland.nix import since we're switching to X11
    # ./hyprland.nix
    ./neovim.nix
    ./starship.nix
    ./i3.nix  # New i3 configuration (if using i3)
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
    autotiling # i3 specific
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
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "history-substring-search"
        "sudo"
      ];
      theme = "robbyrussell";
    };
  };

  programs.ghostty = {
    enable = true;
    settings = {
      background-opacity = "0.95";  # 0.0 = fully transparent, 1.0 = fully opaque
      font-family = "GeistMono Nerd Font";
      font-size = 12;
    };
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
