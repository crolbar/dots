{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains.idea-community
    jdt-language-server
  ];
}
