{
  imports = [./scripts];

  programs.eww = {
    enable = true;
    enableZshIntegration = true;
    configDir = ./eww;
  };
}
