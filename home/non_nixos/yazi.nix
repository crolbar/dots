{pkgs, ...} @ args: {
  programs.yazi = let
    origin = (import ../../hosts/shared/cli/yazi.nix args).programs.yazi;
    settings = origin.settings.yazi;
  in {
    enable = true;
    inherit settings;
  };
}
