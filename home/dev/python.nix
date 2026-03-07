{pkgs, ...}: {
  home.packages = with pkgs; [
    (python313.withPackages (ppkgs:
      with ppkgs; [
        requests
        pip
        sympy
      ]))
    pyright
  ];
}
