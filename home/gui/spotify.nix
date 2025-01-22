{
  spicetify-nix,
  pkgs,
  ...
}: {
  programs.spicetify = let
    spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;

    spotifyPackage = pkgs.spotify.overrideAttrs (old: {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
    });

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
      lyricsPlus
      newReleases
    ];
  };
}
