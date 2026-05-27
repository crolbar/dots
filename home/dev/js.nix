{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs
    yarn
    typescript-language-server
    prettier
    typescript
  ];
}
