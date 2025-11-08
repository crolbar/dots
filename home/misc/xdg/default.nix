{
  config,
  pkgs,
  ...
} @ attr: let
  associations = import ./associations.nix attr;
in {
  xdg = {
    enable = true;
    configFile."mimeapps.list".force = true;

    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";

    # portal.enable = lib.mkForce false;

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
