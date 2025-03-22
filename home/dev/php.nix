{pkgs, ...}: {
  home.packages = with pkgs; [
    #phpactor
    php83Packages.composer
    php83
  ];
}
