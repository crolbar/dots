{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = 300;
        height = 300;
        origin = "top-left";
        offset = "10x50";
        scale = 0;
        notification_limit = 20;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 0;
        icon_corner_radius = 0;
        indicate_hidden = "yes";
        transparency = 0;
        separator_height = 2;
        padding = 12;
        horizontal_padding = 12;
        text_icon_padding = 0;
        frame_width = 2;
        #frame_color = "#7eb8cc";
        frame_color = "#ffffff";
        gap_size = 0;
        separator_color = "frame";
        sort = "yes";
        font = "Roboto mono 12";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = "140";
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        enable_recursive_icon_lookup = true;
        icon_position = "left";
        min_icon_size = 42;
        max_icon_size = 128;
        icon_path = "/usr/share/icons/Papirus-Dark/16x16/";
        sticky_history = "yes";
        history_length = 20;
        dmenu = "/usr/bin/dmenu -p dunst:";
        browser = "/usr/bin/firefox";
        always_run_script = true;
        title = "Dunst";
        class = "Dunst";
        corner_radius = 10;
        ignore_dbusclose = false;
        force_xinerama = false;
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
        per_monitor_dpi = false;
      };

      urgency_low = {
        background = "#000000";
        foreground = "#ffffff";
        timeout = 10;
      };
      urgency_normal = {
        background = "#000000";
        foreground = "#ffffff";
        timeout = 10;
      };

      urgency_critical = {
        background = "#900000";
        foreground = "#ffffff";
        frame_color = "#ff0000";
        timeout = 0;
      };
    };
  };
}
