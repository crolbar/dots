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
    ./wm/niri
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
    ./gui/browsers/zen-browser.nix

    ./wm/bsp
    ./wm/hypr
    ./misc
    ../overlays.nix
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
    ./gui/eww
    ./gui/spotify.nix
    ./gui/browsers/zen-browser.nix
  ];

  win = [
    ./cli
    ./editors/helix
    ./misc/agenix.nix
  ];
}
