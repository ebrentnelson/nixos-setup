# /etc/nixos/configuration.nix - i3 tiling window manager
{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network configuration
  networking.hostName = "moroni";
  networking.networkmanager.enable = true;

  # Upgrades
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  # Garbage Collection
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;

  # Time zone and internationalization
  time.timeZone = "America/Boise";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable X11 with i3
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu      # Application launcher
        i3status   # Status bar
        i3lock     # Screen locker
        i3blocks   # Alternative status bar
      ];
    };
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User account
  users.users.ebn = {
    isNormalUser = true;
    description = "E Brent Nelson";
    extraGroups = [ "networkmanager" "wheel" "input"];
    shell = pkgs.zsh;
  };

  # Enable zsh system-wide
  programs.zsh.enable = true;

  # Enable file manager
  programs.thunar.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    # Development tools
    git
    gh
    neovim
    silver-searcher # ag

    # Applications
    google-chrome
    firefox
    ghostty
    spotify
    dropbox
    obsidian
    synergy

    # i3-specific utilities
    rofi           # Better application launcher than dmenu
    polybar        # More modern status bar
    feh            # Image viewer and wallpaper setter
    scrot          # Screenshot utility
    xclip          # Clipboard utilities
    picom          # Compositor for transparency/effects

    # System utilities
    networkmanagerapplet
    pavucontrol    # Audio control
    brightnessctl  # Brightness control (for laptops)
    arandr         # GUI for xrandr (monitor configuration)
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.geist-mono
    nerd-fonts.iosevka-term
    nerd-fonts.lilex
    nerd-fonts.open-dyslexic
    nerd-fonts.zed-mono
  ];

  # Enable some services
  services.openssh.enable = true;
  services.printing.enable = true; # CUPS printing

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 24800 ];
    allowedUDPPorts = [ ];
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release
  system.stateVersion = "25.05";
}
