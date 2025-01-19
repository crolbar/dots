{pkgs, ...} @ attrs: let
  speakerSink = "GP106";
in {
  imports = [
    (import ./pulse.nix (attrs // {inherit speakerSink;}))
    ./bsp.nix
  ];
}
