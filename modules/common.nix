{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network configuration
  networking.networkmanager.enable = true;

  # Upgrades and garbage collection
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
  nix.settings.auto-optimise-store = true;

  # Time zone and internationalization
  time.timeZone = "America/Boise";
  i18n.defaultLocale = "en_US.UTF-8";

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.zsh.enable = true;
  programs.thunar.enable = true;
  programs.dconf.enable = true;

  # Common system packages
  environment.systemPackages = with pkgs; [
    # Development Tools
    git
    gh
    neovim
    nodejs
    clojure
    leiningen
    silver-searcher
    openjdk17
    awsci2
    terraform
    dart
    flutter

    # Build Tools
    gcc
    gnumake
    pkg-config

    # Web Browsers
    chromium
    firefox

    # Applications
    ghostty
    spotify
    dropbox
    obsidian

    # System Utilities
    networkmanagerapplet
    alsa-utils
    pavucontrol  
    brightnessctl 
    imagemagick

    # Themes
    papirus-icon-theme
  ];

  environment.variables = {
    TERMINAL = "ghostty";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.geist-mono
    nerd-fonts.iosevka-term
    nerd-fonts.lilex
    nerd-fonts.open-dyslexic
    nerd-fonts.zed-mono
  ];

  services.openssh.enable = true;
  services.printing.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 24800 ];
    allowedUDPPorts = [ ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
}

