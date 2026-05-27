{pkgs, ...}: {
  imports = [
    ./c.nix
    ./go.nix
    ./ocaml.nix
    ./java.nix
    ./js.nix
    ./lua.nix
    ./nix.nix
    ./php.nix
    ./python.nix
    ./rust.nix
    ./zig.nix
  ];

  home.packages = with pkgs; [
    bash-language-server
    vscode-langservers-extracted
  ];
}
