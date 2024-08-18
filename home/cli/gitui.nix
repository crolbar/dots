{
  programs.gitui = {
    enable = true;

    keyConfig = ''
      (
       move_left: Some((code: Char('h'), modifiers: "")),
       move_right: Some((code: Char('l'), modifiers: "")),
       move_up: Some((code: Char('k'), modifiers: "")),
       move_down: Some((code: Char('j'), modifiers: "")),

       shift_up: Some((code: Char('K'), modifiers: "SHIFT")),
       shift_down: Some((code: Char('J'), modifiers: "SHIFT")),

       page_down: Some((code: Char('d'), modifiers: "CONTROL")),
       page_up: Some((code: Char('u'), modifiers: "CONTROL")),

       stash_open: Some((code: Char('l'), modifiers: "")),
       open_help: Some((code: F(1), modifiers: "")),

       status_reset_item: Some((code: Char('U'), modifiers: "SHIFT")),
      )
    '';

    theme = ''
      (
        selected_tab: Some("Reset"),
        command_fg: Some("White"),
        selection_bg: Some("DarkGray"),
        selection_fg: Some("White"),
        cmdbar_bg: Some("Reset"),
        cmdbar_extra_lines_bg: Some("Black"),
        disabled_fg: Some("DarkGray"),
        diff_line_add: Some("Green"),
        diff_line_delete: Some("Red"),
        diff_file_added: Some("LightGreen"),
        diff_file_removed: Some("LightRed"),
        diff_file_moved: Some("LightMagenta"),
        diff_file_modified: Some("Cyan"),
        commit_hash: Some("Green"),
        commit_time: Some("Blue"),
        commit_author: Some("Gray"),
        danger_fg: Some("Red"),
        push_gauge_bg: Some("Blue"),
        push_gauge_fg: Some("Reset"),
        tag_fg: Some("LightMagenta"),
        branch_fg: Some("Red"),
        line_break: Some("¶"),
        block_title_focused: Some("Reset"),
      )
    '';
  };
}
