{
  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      proc_gradient = false;
      proc_sorting = "cpu direct";
      update_ms = 1000;
    };
  };
}
