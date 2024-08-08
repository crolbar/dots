{
  config,
  pkgs,
  ...
}: let
  browser = ["Schizofox.desktop"];
  fileManager = ["yazi.desktop"];
  imageViewer = ["org.gnome.Loupe"];
  videoPlayer = ["mpv.desktop"];
  audioPlayer = ["mpv.desktop"];
  textEditor = ["nvim.desktop"];
  discordClient = ["vesktop.desktop"];
  spotifyClient = ["spotify.desktop"];
  pdfPlayer = ["zathura.desktop"];

  #mail = [""];

  associations = {
    "text/html" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "x-scheme-handler/chrome" = ["chromium-browser.desktop"];

    "application/json" = browser;
    "application/xhtml+xml" = browser;
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xhtml" = browser;
    "application/x-extension-xht" = browser;

    "text/plain" = textEditor;
    "inode/directory" = fileManager;

    "audio/*" = audioPlayer;
    "video/*" = videoPlayer;
    "image/*" = imageViewer;

    "application/pdf" = pdfPlayer;
    "application/x-xz-compressed-tar" = ["org.gnome.FileRoller.desktop"];

    "x-scheme-handler/spotify" = spotifyClient;
    "x-scheme-handler/discord" = discordClient;
    #"x-scheme-handler/mailto" = mail;
  };
in {
  xdg = {
    enable = true;
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    userDirs = {
      enable = true;
      createDirectories = true;
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      videos = "${config.home.homeDirectory}/Videos";
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.home.homeDirectory}/Screenshots";
        #XDG_MAIL_DIR = "${config.home.homeDirectory}/Mail";
      };
    };

    mimeApps = {
      enable = true;
      associations.added = associations;
      defaultApplications = associations;
    };
  };

  # use alacritty as an terminal emulator to open terminal apps (like yazi or nvim) with xdg-open
  home.packages = [
    pkgs.xdg-utils
    (
      pkgs.writeTextFile {
        name = "xdg-terminal-exec";
        destination = "/bin/xdg-terminal-exec";
        text = "#!${pkgs.runtimeShell}\nalacritty -e \"$@\"";
        executable = true;
      }
    )
  ];
}
