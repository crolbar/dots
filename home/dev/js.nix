{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs
    yarn
    typescript-language-server
    nodePackages.prettier
    nodePackages.typescript
  ];
}
