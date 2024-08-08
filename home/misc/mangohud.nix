{
  programs.mangohud = {
    enable = true;
    settings = {
      gpu_stats = true;
      gpu_temp = true;

      cpu_stats = true;
      cpu_temp = true;

      ram = true;
      procmem = true;

      fps = true;
      frametime = true;

      font_size = 24;
      position = "top-right";

      engine_version = true;
      wine = true;

      fsr = true;

      no_display = true;
      toggle_hud = "Shift_L+F12";
    };
  };
}
