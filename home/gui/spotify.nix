{
  spicetify-nix,
  pkgs,
  ...
}: {
  imports = [spicetify-nix.homeManagerModules.default];

  programs.spicetify = let
    spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      shuffle
      adblock
      bookmark
      groupSession
      songStats
      betterGenres

      beautifulLyrics
      popupLyrics

      fullScreen
    ];
    enabledCustomApps = with spicePkgs.apps; [
      reddit
      lyricsPlus
      newReleases
    ];
    theme = spicePkgs.themes.starryNight;
  };
}
