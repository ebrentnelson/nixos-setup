{ desktop }: { config, pkgs, lib, ... }:

{
  imports = [
    ./modules/neovim.nix
    ./modules/starship.nix
    ./modules/ghostty.nix
    ./modules/gtk.nix
  ] ++ lib.optionals (desktop == "i3") [
      ./modules/i3.nix 
      ./modules/polybar.nix
      ./modules/rofi.nix
      ./modules/dunst.nix
    ] ++ lib.optionals (desktop == "hyprland") [
      ./modules/hyprland.nix
      ./modules/waybar.nix
      ./modules/wofi.nix
      ./modules/wlogout.nix
      ./modules/mako.nix
    ];

  home.username = "ebn";
  home.homeDirectory = "/home/ebn";
  home.stateVersion = "25.05";

  home.packages = with pkgs; []
    ++ lib.optionals (desktop == "i3") [
      autotiling 
    ];

  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 16;
  };

  programs.git = {
    enable = true;
    userName = "E Brent Nelson";
    userEmail = "ebrentnelson@gmail.com"; 
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "history-substring-search"
        "sudo"
      ];
      theme = "robbyrussell";
    };
  };

  programs.home-manager.enable = true;
}
