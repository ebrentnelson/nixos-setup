{ pkgs, ... }:

{
  # These will automatically use the current user's info
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "25.05";

  imports = [
    ../modules/neovim.nix
    ../modules/starship.nix  
    ../modules/ghostty.nix
  ];

  programs.home-manager.enable = true;
}
