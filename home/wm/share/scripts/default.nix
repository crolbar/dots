{pkgs, ...} @ args: let
  # names are Properties.application.name from `pactl list sink-inputs`
  musicPlayer = "Music Player Daemon";
  # musicPlayer = "spotify";
  browser = "Firefox";
in {
  imports = [
    ./default-sink.nix
    ./rgb.nix
    (import ./volume.nix (args // {inherit browser musicPlayer;}))
  ];
}
