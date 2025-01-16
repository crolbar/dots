{
  pkgs,
  lib,
  config,
  ...
} @ attrs: let
  inherit (attrs) settings;
  inherit
    (settings.keys)
    mod
    shift
    ctrl
    alt
    media
    ;

  inherit
    (settings.cmds)
    fullScreen
    exec
    killFocused
    floatingToggle
    moveFocus
    # TODO?
    moveWindow
    resizeWindow
    ;

  helpers = {
    # from
    # vimBinds [[mod] moveFocus]
    #
    # to
    #
    # [
    #   [[mod] "k" moveFocus.up]
    #   [[mod] "j" moveFocus.down]
    #   [[mod] "h" moveFocus.left]
    #   [[mod] "l" moveFocus.right]
    # ];
    # takes a list of mods at index 0 that is an list of modifiyers and
    # `cmdSet` at index 1 that is an attr set with fields up, down, left, right
    vimBinds = ops: let
      cmdSet = builtins.elemAt ops 1;
      mods = builtins.elemAt ops 0;
    in
      map (key: let
        cmdMap = {
          "k" = cmdSet.up;
          "j" = cmdSet.down;
          "h" = cmdSet.left;
          "l" = cmdSet.right;
        };
      in [mods key cmdMap.${key}]) ["k" "j" "h" "l"];
  };

  homeDir = config.home.homeDirectory;

  bins = {
    foot = lib.getExe config.programs.foot.package;
    anyrun = lib.getExe config.programs.anyrun.package;
    playerctl = lib.getExe pkgs.playerctl;
    pamixer = lib.getExe pkgs.pamixer;
  };

  scripts = {
    wall = config.home.homeDirectory + "/scripts/wall.sh"; # from ./share/wall/wall.nix
    volume = homeDir + "/.config/hypr/scripts/volume.sh"; # move out of hypr ?
    volumeEww = homeDir + "/scripts/eww/volume.sh"; # move out of eww ?
  };

  spawners = [
    [[mod] "x" "${exec} ${bins.foot}"]
    [[mod] "r" "${exec} ${bins.anyrun}"]

    [[mod] "a" "${exec} ${scripts.wall} f"]
    [[mod shift] "a" "${exec} ${scripts.wall} b"]
  ];

  mediaControl = {
    # music player defined in ./hypr/scripts/default.nix
    music = [
      [[mod shift alt] "F11" "${exec} ${scripts.volume} music-"]
      [[mod shift alt] "F12" "${exec} ${scripts.volume} music+"]
      [[mod shift alt] "F7" "${exec} ${scripts.volumeEww} music mute"]
    ];

    # (browser defined in ./hypr/scripts/default.nix)
    browser = [
      [[mod shift alt] "F9" "${exec} ${scripts.volume} browser-"]
      [[mod shift alt] "F10" "${exec} ${scripts.volume} browser+"]
      [[mod shift alt] "F8" "${exec} ${scripts.volumeEww} browser mute"]
    ];

    system = [
      [[] media.play "${exec} ${bins.playerctl} play-pause"]
      [[] media.next "${exec} ${bins.playerctl} next"]
      [[] media.prev "${exec} ${bins.playerctl} previous"]
      [[] media.lowerVolume "${exec} ${bins.pamixer} -d 5"]
      [[] media.raiseVolume "${exec} ${bins.pamixer} -i 5"]
    ];
  };

  window = {
    # window control
    control = [
      [[mod] "f" fullScreen]
      [[mod shift] "q" killFocused]
      [[mod] "z" floatingToggle]
    ];

    focus = helpers.vimBinds [[mod] moveFocus];
    move = helpers.vimBinds [[mod ctrl] moveWindow];
    resize = helpers.vimBinds [[mod shift] resizeWindow];
  };
in
  spawners
  ++ window.control
  ++ window.focus
  ++ window.move
  ++ window.resize
  ++ mediaControl.music
  ++ mediaControl.browser
  ++ mediaControl.system
