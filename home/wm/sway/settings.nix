let
  keybindings = ./binds.nix;
in {
  modifier = "Mod4";
  window.titlebar = false;
  floating.titlebar = false;
  gaps.smartBorders = "on";

  input = {
    "*" = {
      pointer_accel = "-0.9";
      repeat_delay = "300";
      repeat_rate = "50";
    };
    "5824:10203:crolbar_YUKI" = {
      accel_profile = "adaptive";
      pointer_accel = "-0.2";
    };
  };

  output = {
    "DP-1" = {
      mode = "1920x1080@144Hz";
      position = "0,0";
      scale = "1.0";
      transform = "normal";
    };
  };

  inherit keybindings;
}
