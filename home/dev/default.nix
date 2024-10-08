{pkgs, ...}: {
  imports = [
    ./c.nix
    ./go.nix
    ./java.nix
    ./js.nix
    ./lua.nix
    ./nix.nix
    ./php.nix
    ./python.nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    nodePackages_latest.bash-language-server
    nodePackages_latest.vscode-langservers-extracted
  ];
}
