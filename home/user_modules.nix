{
  crolbar = [
    ./cli
    ./cli/zzz
    ./cli/leetcode_cli.nix
    ./misc/agenix.nix
    ./gui
    ./editors
    ./dev
    ./wm/i3
    ./wm/hypr
    ./wm/sway
    ./misc
    ../overlays.nix
    ./misc/mangohud.nix
    ./gui/KeyboardVisualizer.nix
  ];

  plier = [
    ./cli
    ./cli/zzz
    ./cli/leetcode_cli.nix
    ./misc/agenix.nix
    ./gui
    ./editors
    ./dev
    ./wm/left
    ./wm/river
    ./wm/hypr
    ./misc
    ../overlays.nix
  ];

  kubo = [
    ./cli
    ./dev
    ./editors

    ./gui/term_emulators/alacritty.nix
    ./gui/zathura.nix
    ./gui/eww
    ./gui/schizofox.nix

    ./wm/bsp
    ./wm/hypr
    ./misc
  ];

  screw = [
    ./cli
    ./editors
  ];

  pvm = [
    ./cli
    ./editors
    ./misc/agenix.nix
    ./cli/zzz
    ../overlays.nix
  ];
}
