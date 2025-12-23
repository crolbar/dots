{pkgs, ...}: {
  programs.chromium = {
    enable = true;

    package = pkgs.vivaldi;

    extensions = [
      {id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # sponsor block
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock
      {id = "pccckmaobkjjboncdfnnofkonhgpceea";} # hover zoom+
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # dark reader
      {id = "dbepggeogbaibhgnhhndojpepiihcmeb";} # vimium
      {id = "egmgebeelgaakhaoodlmnimbfemfgdah";} # redirect blocker
      {id = "edibdbjcniadpccecjdfdjjppcpchdlm";} # i still don't care about cookies
      {id = "efaagigdgamehbpimpiagfpoihlkgamh";} # don't f*** with paste
    ];

    commandLineArgs = [
      "--disable-search-engine-collection"
      "--extension-mime-request-handling=always-prompt-for-install"
      "--fingerprinting-canvas-image-data-noise"
      "--fingerprinting-canvas-measuretext-noise"
      "--fingerprinting-client-rects-noise"
      "--show-avatar-button=incognito-and-guest"

      "--force-dark-mode"

      "--enable-gpu-rasterization"
      "--enable-oop-rasterization"
      "--enable-zero-copy"
      "--ignore-gpu-blocklist"

      "--no-default-browser-check"
      "--no-service-autorun"
      "--disable-features=PreloadMediaEngagementData,MediaEngagementBypassAutoplayPolicies"
      "--disable-reading-from-canvas"
      "--no-pings"
      "--no-first-run"
      "--no-experiments"
      "--no-crash-upload"
      "--disable-wake-on-wifi"
      "--disable-breakpad"
      # "--disable-sync"
      "--disable-speech-api"
      "--disable-speech-synthesis-api"
      # "--ozone-platform=wayland"
      "--enable-features=UseOzonePlatform"
    ];
  };
}
