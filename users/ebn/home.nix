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

  programs.kitty = {
    enable = true;
    font = {
      name = "OpenDyslexic";
      size = 12;
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 1300;
      scan_timeout = 50;
      format = "$all$nix_shell$nodejs$python$clojure$git_branch$git_commit$git_state$git_status\n$username$hostname$directory";
      character = {
        success_symbol = "[](bold green) ";
        error_symbol = "[✗](bold red) ";
      };
    };
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
}
