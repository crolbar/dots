{pkgs, ...} @ args: let
  # names are Properties.application.name from `pactl list sink-inputs`
  # musicPlayer = "Music Player Daemon";
  musicPlayer = "spotify";
  browser = "Firefox";
  speakerSink = "GP106";
in {
  imports = [
    ./default-sink.nix
    ./rgb.nix
    (import ./volume.nix (args // {inherit browser musicPlayer;}))
    (import ./pulse.nix {inherit pkgs speakerSink;})
  ];
}
