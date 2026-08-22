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
    ./wm/niri
    ./wm/red
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
    ./editors/helix
    ./dev
    ./wm/niri
    ./wm/red
    ./misc
    ../overlays.nix
  ];

  kubo = [
    ./cli
    ./dev
    ./editors

    ./wm/bsp
    ./wm/hypr
    ./misc
    ../overlays.nix
  ];

  screw = [
    ./cli
    ./editors/helix
  ];

  pvm = [
    ./cli
    ./editors
    ./misc/agenix.nix
    ./cli/zzz
    ../overlays.nix
  ];

  crolchy = [
    ./cli
    ./editors
    ./misc/agenix.nix
    ./misc/mpd.nix

    ./cli/zzz/dapu.nix
    ../overlays.nix
    ./dev/nix.nix
    ./gui/zathura.nix

    # ./wm/niri
    ./gui/spotify.nix
    ./gui/browsers/zen-browser.nix
  ];

  win = [
    ./cli
    ./editors/helix
    ./misc/agenix.nix
  ];
}
