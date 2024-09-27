{self, ...}: {
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    checks = {
      alejandra = pkgs.runCommand "alejandra-format" {} ''
        ${lib.getExe pkgs.alejandra} --check ${self} | tee $out
      '';
    };
  };
}
