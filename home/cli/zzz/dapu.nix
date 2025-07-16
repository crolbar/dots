{
  pkgs,
  config,
  lib,
  ...
}: let
  editorT = "helix";
  editor = lib.getExe config.programs.${editorT}.package;
  tmux = lib.getExe config.programs.tmux.package;
  dapu = lib.getExe' pkgs.dapu "dapu";
in {
  home.packages = [pkgs.dapu];

  home.file."scripts/dapu.sh".source = pkgs.writers.writeBash "dapu.sh" ''
    output=$(${dapu} -o)

    if [[ -e $output ]]; then
        if [[ -d $output ]]; then
            cd "$output" || exit
        else
            cd "$(dirname "$output")" || exit
        fi
        if [ -n "$TMUX" ]; then
            ${tmux} rename-window "$(basename "$PWD")"
        fi
        if [[ $1 != "cd" ]]; then
            if [[ -e $output/flake.nix ]]; then
                nix develop --command bash -c "SHELL=zsh && ${editor} ."
            elif [[ -e $output/shell.nix ]]; then
                nix-shell --run "bash -c \"SHELL=zsh && ${editor} .\""
            else
                ${editor} "$output"
            fi
        fi
    fi
  '';
}
