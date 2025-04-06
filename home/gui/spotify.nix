{
  spicetify-nix,
  pkgs,
  ...
}: {
  programs.spicetify = let
    spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      groupSession
      songStats
      betterGenres
      popupLyrics
      fullScreen
    ];

    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      newReleases
    ];
  };
}
