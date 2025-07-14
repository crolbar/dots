{
  perSystem = {
    config,
    pkgs,
    lib,
    ...
  }: let
    pre-commit = let
      tree = lib.getExe pkgs.tree;
      sed = lib.getExe' pkgs.gnused "sed";
      tr = lib.getExe' pkgs.coreutils-full "tr";
      awk = lib.getExe' pkgs.gawk "awk";
    in
      pkgs.writers.writeBashBin "pre-commit.sh"
      ''
        export LANG=en_US.UTF-8
        export LC_ALL=

        README="README.md"
        VAL="$(${tree} --dirsfirst --gitignore | ${sed} 's/$/\\n/' | ${tr} -d '\n')"

        CODE_BLOCK_START="\`\`\`nix"
        CODE_BLOCK_END="\`\`\`"

        ${awk} -v start="$CODE_BLOCK_START" -v end="$CODE_BLOCK_END" -v tree_output="$VAL" '
        BEGIN {in_block = 0}
        $0 == start {in_block = 1; print $0; print tree_output; next}
        $0 == end && in_block {in_block = 0; print $0; next}
        in_block == 0 {print $0}
        ' "$README" > tmp && mv tmp "$README"

        git add $README
      '';
  in {
    devShells.default = pkgs.mkShellNoCC {
      name = "dots";

      packages = with pkgs; [
        alejandra
        git
        nil
      ];

      # install pre commit hook
      shellHook = ''
        cp ${lib.getExe pre-commit} .git/hooks/pre-commit
      '';
    };

    packages.up-README = pre-commit;

    formatter = pkgs.alejandra;
  };
}
