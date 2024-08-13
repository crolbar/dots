{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    devShells.default = pkgs.mkShellNoCC {
      name = "dots";

      packages = with pkgs; [
        alejandra
        git
        nil
      ];
    };

    formatter = pkgs.alejandra;
  };
}
