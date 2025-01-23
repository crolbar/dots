{clib, ...}: {
  programs.gitui = {
    enable = true;

    keyConfig = let
      Char = ch: n: "Char('${ch}')";
      F = num: n: "F(${toString num})";
      setMods = modifiers: code: {inherit code modifiers;};
      noMods = code: setMods "" code;
      shift = code: setMods "SHIFT" code;
      ctrl = code: setMods "CONTROL" code;
    in
      clib.toRonImpSome {
        move_up = noMods (Char "k");
        move_down = noMods (Char "j");
        move_left = noMods (Char "h");
        move_right = noMods (Char "l");

        shift_up = noMods (Char "g");
        shift_down = shift (Char "g");
        page_down = ctrl (Char "u");

        stash_open = noMods (Char "l");
        open_help = noMods (F 1);

        status_reset_item = shift (Char "U");
      };

    theme = clib.toRonImpSome {
      selected_tab = "Reset";
      command_fg = "White";
      selection_bg = "DarkGray";
      selection_fg = "White";
      cmdbar_bg = "Reset";
      cmdbar_extra_lines_bg = "Black";
      disabled_fg = "DarkGray";
      diff_line_add = "Green";
      diff_line_delete = "Red";
      diff_file_added = "LightGreen";
      diff_file_removed = "LightRed";
      diff_file_moved = "LightMagenta";
      diff_file_modified = "Cyan";
      commit_hash = "Green";
      commit_time = "Blue";
      commit_author = "Gray";
      danger_fg = "Red";
      push_gauge_bg = "Blue";
      push_gauge_fg = "Reset";
      tag_fg = "LightMagenta";
      branch_fg = "Red";
      line_break = "¶";
      block_title_focused = "Reset";
    };
  };
}
