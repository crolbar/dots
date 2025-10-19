{pkgs, ...}: {
  home.packages = with pkgs; [
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocamlformat
    ocamlPackages.dune_3
    ocaml
  ];
}
