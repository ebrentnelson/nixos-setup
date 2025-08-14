{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network
  networking.networkmanager.enable = true;

  # Ultra-aggressive storage management
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 1d";
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Time/locale
  time.timeZone = "America/Boise";
  i18n.defaultLocale = "en_US.UTF-8";

  # Audio (minimal for web videos)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Enable X11 with dwm (lightest window manager possible)
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.dwm.enable = true;
  };

  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;

  # ABSOLUTE MINIMAL packages - only 4 packages!
  environment.systemPackages = with pkgs; [
    # Smallest possible browser that still works with modern web
    midori # ~15MB vs Chromium's ~200MB+

    # Smallest terminal that supports your theme
    st # ~2MB simple terminal from suckless

    # Network management
    networkmanagerapplet # Essential for wifi

    # Volume control for web videos
    alsa-utils # For basic audio
  ];

  # Minimal user config inline
  users.users.ebn = {
    isNormalUser = true;
    description = "E Brent Nelson";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  # No Home Manager - direct config for ultimate minimalism
  environment.etc."st/config.h".text = ''
    /* Hot pink + dark theme for st terminal */
    static char *colorname[] = {
      "#111111",  /* black   */
      "#fe386e",  /* red     */
      "#888888",  /* green   */
      "#cccccc",  /* yellow  */
      "#666666",  /* blue    */
      "#fe386e",  /* magenta */
      "#aaaaaa",  /* cyan    */
      "#f9f9f9",  /* white   */
      "#333333",  /* bright black   */
      "#fe386e",  /* bright red     */
      "#aaaaaa",  /* bright green   */
      "#f9f9f9",  /* bright yellow  */
      "#888888",  /* bright blue    */
      "#fe386e",  /* bright magenta */
      "#cccccc",  /* bright cyan    */
      "#ffffff",  /* bright white   */
    };
    static unsigned int defaultfg = 7;
    static unsigned int defaultbg = 0;
    static unsigned int defaultcs = 256;
    static unsigned int defaultrcs = 257;

    /* Font */
    static char *font = "monospace:pixelsize=14:antialias=true:autohint=true";

    /* Transparency */
    static float alpha = 0.95;
  '';

  # Dwm config for your shortcuts + TILING (compile-time config)
  environment.etc."dwm/config.h".text = ''
    /* Hot pink + dark dwm theme with TILING */
    static const char col_gray1[]       = "#111111";
    static const char col_gray2[]       = "#333333";  
    static const char col_gray3[]       = "#f9f9f9";
    static const char col_gray4[]       = "#ffffff";
    static const char col_cyan[]        = "#fe386e";
    static const char *colors[][3]      = {
      /*               fg         bg         border   */
      [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
      [SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
    };

    /* Gaps for that sexy tiled look */
    static const unsigned int gappx     = 5;        /* gaps between windows */
    static const unsigned int borderpx  = 4;        /* border pixel size */
    static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */

    /* Commands for your shortcuts */
    static const char *termcmd[]  = { "st", NULL };
    static const char *browsercmd[] = { "midori", NULL };
    static const char *claudecmd[] = { "midori", "https://claude.ai/", NULL };
    static const char *emailcmd[] = { "midori", "https://mail.google.com/", NULL };
    static const char *calcmd[] = { "midori", "https://calendar.google.com/", NULL };
    static const char *whatsappcmd[] = { "midori", "https://web.whatsapp.com/", NULL };
    static const char *msgcmd[] = { "midori", "https://messages.google.com/web/", NULL };
    static const char *figmacmd[] = { "midori", "https://figma.com/", NULL };

    static Key keys[] = {
      /* modifier                     key        function        argument */
      { MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
      { MODKEY,                       XK_b,      spawn,          {.v = browsercmd } },
      { MODKEY,                       XK_a,      spawn,          {.v = claudecmd } },
      { MODKEY,                       XK_e,      spawn,          {.v = emailcmd } },
      { MODKEY,                       XK_c,      spawn,          {.v = calcmd } },
      { MODKEY|ShiftMask,             XK_g,      spawn,          {.v = whatsappcmd } },
      { MODKEY|ShiftMask,             XK_h,      spawn,          {.v = msgcmd } },
      { MODKEY|ShiftMask,             XK_f,      spawn,          {.v = figmacmd } },
      { MODKEY,                       XK_w,      killclient,     {0} },
      
      /* TILING CONTROLS */
      { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
      { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
      { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
      { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
      { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} }, /* tile */
      { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} }, /* float */
      { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} }, /* monocle */
      { MODKEY,                       XK_space,  setlayout,      {0} },
      { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
      
      /* Your workspace shortcuts 1-5 */
      { MODKEY,                       XK_1,      view,           {.ui = 1 << 0} },
      { MODKEY,                       XK_2,      view,           {.ui = 1 << 1} },
      { MODKEY,                       XK_3,      view,           {.ui = 1 << 2} },
      { MODKEY,                       XK_4,      view,           {.ui = 1 << 3} },
      { MODKEY,                       XK_5,      view,           {.ui = 1 << 4} },
      { MODKEY|ShiftMask,             XK_1,      tag,            {.ui = 1 << 0} },
      { MODKEY|ShiftMask,             XK_2,      tag,            {.ui = 1 << 1} },
      { MODKEY|ShiftMask,             XK_3,      tag,            {.ui = 1 << 2} },
      { MODKEY|ShiftMask,             XK_4,      tag,            {.ui = 1 << 3} },
      { MODKEY|ShiftMask,             XK_5,      tag,            {.ui = 1 << 4} },
    };
  '';

  # Zsh config inline (no oh-my-zsh)
  programs.zsh.promptInit = ''
    # Hot pink prompt
    export PROMPT='%F{#fe386e}%n@%m%f:%F{#f9f9f9}%~%f$ '
  '';

  system.stateVersion = "25.05";
}
