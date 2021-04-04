{
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Meslo";
      font_size = 12;
      cursor_stop_blinking_after = 30;

      scrollback_lines = 10000;

      # Strip normal selections
      # Don't strip rectangular selections
      strip_trailing_spaces = "smart";

      enable_audio_bell = "no";
      window_alert_on_bell = "yes";
      bell_on_tab = "yes";

      confirm_os_window_close = 1;

      tar_bar_style = "powerline";
      tab_activity_symbol = "*";

      foreground_opacity = "0.9";
    };
  };
}
