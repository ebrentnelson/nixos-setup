# /etc/nixos/configuration.nix
{ config, pkgs, ... }:

{
  # imports =
  #   [ # Include the results of the hardware scan.
  #     ./hardware-configuration.nix
  #   ];
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
    # withUWSM = true;
  };

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
    shell = pkgs.zsh;
  };

  # Enable zsh system-wide
  programs.zsh.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    # Development tools
    git
    neovim
    silver-searcher # ag

    # Applications
    google-chrome
    #ghostty
    spotify
    #synergy
    deskflow
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

    # Terminal
    kitty          # Alternative terminal (you have ghostty too)
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
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release
  system.stateVersion = "25.05";
}
