{pkgs, ...} @ args: let
  # names are Properties.application.name from `pactl list sink-inputs`
  # musicPlayer = "Music Player Daemon";
  musicPlayer = "spotify";
  browser = "Vivaldi";
  speakerSink = "Navi";
in {
  imports = [
    ./default-sink.nix
    ./rgb.nix
    (import ./volume.nix (args // {inherit browser musicPlayer;}))
    (import ./pulse.nix {inherit pkgs speakerSink;})
    ./niri.nix
    ./niri_workspace_scroll.nix
  ];
}
