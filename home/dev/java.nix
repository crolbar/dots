{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains.idea-community-bin
    jdt-language-server
  ];
}
