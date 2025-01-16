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

  bins = {
    foot = lib.getExe config.programs.foot.package;
    anyrun = lib.getExe config.programs.anyrun.package;
  };

  scripts = {
    wall = config.home.homeDirectory + "/scripts/wall.sh"; # from ./share/wall/wall.nix
  };

  spawners = [
    [[mod] "x" "${exec} ${bins.foot}"]
    [[mod] "r" "${exec} ${bins.anyrun}"]
    [[mod] "a" "${exec} ${scripts.wall} f"]
    [[mod shift] "a" "${exec} ${scripts.wall} b"]
  ];

  helpers = {
    # from
    # [
    #   [[mod] "k" moveFocus.up]
    #   [[mod] "j" moveFocus.down]
    #   [[mod] "h" moveFocus.left]
    #   [[mod] "l" moveFocus.right]
    # ];
    #
    # to
    #
    # vimBinds [[mod] moveFocus]
    #
    # `cmdSet` has to have up, down, left, right fields that are cmds
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
  spawners ++ window.control ++ window.focus ++ window.move ++ window.resize
