{
  crolbar = [
    ./cli
    ./cli/zzz
    ./gui
    ./dev
    ./wm/bsp
    ./wm/hypr
    ./misc
    ../overlays.nix
    ./profiles/crolbar
    ./misc/mangohud.nix
    ./gui/KeyboardVisualizer.nix
  ];

  kubo = [
    ./cli
    ./dev

    ./gui/alacritty.nix
    ./gui/zathura.nix
    ./gui/eww
    ./gui/schizofox.nix

    ./wm/bsp
    ./wm/hypr
    ./misc
    ./profiles/kubo
  ];

  screw = [
    ./cli
    ./profiles/screw
  ];
}
