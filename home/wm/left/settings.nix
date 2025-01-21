{
  modkey = "Super";
  mousekey = "Super";
  workspaces = [];
  tags = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
  layouts = ["MainAndVertStack" "GridHorizontal" "EvenVertical"];
  scratchpad = [
    {
      name = "Alacritty";
      value = "alacritty";
      x = 860;
      y = 390;
      height = 1000;
      width = 1500;
    }
  ];
  window_rules = [
    {
      window_title = "crolk";
      spawn_floating = true;
    }
    {
      window_title = "panel";
      spawn_floating = true;
    }
    {
      window_title = "Volume Control";
      spawn_floating = true;
    }
  ];
  layout_mode = "Tag";
  max_window_width = "None";
  insert_behavior = "Bottom";
  disable_current_tag_swap = true;
  disable_tile_drag = false;
  disable_window_snap = true;
  focus_behaviour = "Sloppy";
  focus_new_windows = true;
  single_window_border = false;
  sloppy_mouse_follows_focus = true;
  auto_derive_workspaces = true;
  state_path = "None";
}
