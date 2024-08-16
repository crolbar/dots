{pkgs, ...}: {
  home.packages = [pkgs.dapu];

  home.file."scripts/dapu.sh" = {
    executable = true;
    text = ''
      #!${pkgs.runtimeShell}
      output=$(dapu -o)

      if [[ -e $output ]]; then
          if [[ -d $output ]]; then
              cd "$output" || exit
          else
              cd "$(dirname "$output")" || exit
          fi
          if [[ $1 != "cd" ]]; then
              if [[ -e $output/flake.nix ]]; then
                  nix develop --command bash -c "SHELL=zsh && nvim ."
              elif [[ -e $output/shell.nix ]]; then
                  nix-shell --run "bash -c \"SHELL=zsh && nvim .\""
              else
                  nvim "$output"
              fi
          fi
      fi
    '';
  };
}
