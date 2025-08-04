# /etc/nixos/configuration.nix
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
      xdg-desktop-portal-wlr
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
    vanilla-dmz    # Sane cursor

    # System utilities
    networkmanagerapplet
    pavucontrol    # Audio control
    brightnessctl  # Brightness control (for laptops)

    # Terminal
    #kitty          # Alternative terminal (you have ghostty too)
  ];

  environment.variables = {
    XCURSOR_THEME = "Vanilla-DMZ";
    XCURSOR_SIZE = "24";
  };

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

  # Deskflow service
  systemd.user.services.deskflow-gui = {
    description = "Deskflow GUI";
    wantedBy = [ "graphical-session.target" ];
    environment = {
      WAYLAND_DISPLAY = "";
      GDK_BACKEND = "x11";
      QT_QPA_PLATFORM = "xcb";
      XDG_SESSION_TYPE = "x11";
      DISPLAY = ":0";
    };
    serviceConfig = {
      ExecStart = "${pkgs.deskflow}/bin/deskflow";
      Restart = "always";
      RestartSec = "5";
    };
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # This value determines the NixOS release
  system.stateVersion = "25.05";
}
