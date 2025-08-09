{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "keyboard";
        
        # Geometry
        width = 350;
        height = 100;
        origin = "top-right";
        offset = "10x10";
        corner_radius = 8;
        
        # Progress bar
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        
        # Appearance
        transparency = 5;
        separator_height = 2;
        padding = 15;
        horizontal_padding = 15;
        frame_width = 2;
        frame_color = "#a6e3a1";
        separator_color = "frame";
        
        # Text
        font = "GeistMono Nerd Font 12";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = 60;
        word_wrap = true;
        ellipsize = "middle";
        ignore_newline = false;
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = true;
        
        # Icons
        icon_position = "left";
        min_icon_size = 32;
        max_icon_size = 48;
        icon_path = "${pkgs.adwaita-icon-theme}/share/icons/Adwaita/scalable/status:${pkgs.adwaita-icon-theme}/share/icons/Adwaita/scalable/devices";
        
        # History
        sticky_history = true;
        history_length = 20;
        
        # Misc
        dmenu = "${pkgs.rofi}/bin/rofi -dmenu -p dunst:";
        browser = "${pkgs.chromium}/bin/chromium";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        startup_notification = false;
        verbosity = "mesg";
        
        # Mouse
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
      
      experimental = {
        per_monitor_dpi = false;
      };
      
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 5;
      };
      
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        timeout = 5;
      };
      
      urgency_critical = {
        background = "#f38ba8";
        foreground = "#1e1e2e";
        frame_color = "#f38ba8";
        timeout = 0;
      };
      
      # Custom rules
      spotify = {
        appname = "Spotify";
        background = "#181825";
        foreground = "#cdd6f4";
        frame_color = "#a6e3a1";
        timeout = 3;
      };
    };
  };
}
