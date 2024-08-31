{pkgs, ...}: {
  home.packages = with pkgs; [
    scriptisto # for c scripts
  ];

  programs.eww = {
    enable = true;
    enableZshIntegration = true;
    configDir = ./eww;
  };
}
