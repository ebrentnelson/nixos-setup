# /etc/nixos/configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network configuration
  networking.hostName = "moroni";
  networking.networkmanager.enable = true;

  # Time zone and internationalization
  time.timeZone = "America/Boise"; # Adjust to your timezone
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system and Wayland
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  # Hyprland configuration
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  # If you don't use hyprlock, you won't need this option
  # security.pam.services.hyprlock = {};

  # XDG portal for screen sharing and file dialogs
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
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
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.bash; # or pkgs.zsh if you prefer
  };

  # System packages
  environment.systemPackages = with pkgs; [
    # Development tools
    git
    neovim
    silver-searcher # ag

    # Applications
    google-chrome
    ghostty
    spotify
    synergy
    dropbox
    obsidian

    # Hyprland essentials
    waybar          # Status bar
    wofi           # Application launcher
    wl-clipboard   # Clipboard utilities
    grim           # Screenshot utility
    slurp          # Screen area selection
    mako           # Notification daemon
    
    # System utilities
    networkmanagerapplet
    pavucontrol    # Audio control
    brightnessctl  # Brightness control (for laptops)
    
    # File manager
    nautilus
    
    # Terminal
    kitty          # Alternative terminal (you have ghostty too)
  ];

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
  ];

  # Enable some services
  services.openssh.enable = true;
  services.printing.enable = true; # CUPS printing

  # Firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  # Enable flakes (optional but recommended)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages (needed for Chrome, Spotify, etc.)
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. Don't change this after installation.
  system.stateVersion = "24.05"; # Check current stable version
}
