{
  imports = [./scripts];

  xdg.configFile."eww".source = ./eww;

  programs.eww.enable = true;
}
