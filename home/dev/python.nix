{pkgs, ...}: {
  home.packages = with pkgs; [
    (python311.withPackages (ppkgs:
      with ppkgs; [
        requests
        pip
      ]))
    pyright
  ];
}
