{ desktop }: { config, pkgs, lib, ... }:

{
  imports = [
    ./modules/neovim.nix
    ./modules/starship.nix
  ] ++ lib.optionals (desktop == "i3") [
      ./modules/i3.nix 
    ] ++ lib.optionals (desktop == "hyprland") [
      ./modules/hyprland.nix
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

  programs.ghostty = {
    enable = true;
    settings = {
      background-opacity = "0.95";  
      font-family = "GeistMono Nerd Font";
      font-size = 12;
      window-decoration = false;
    };
  };

  programs.home-manager.enable = true;
}
