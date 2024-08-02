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
  };
}
