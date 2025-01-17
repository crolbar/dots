{
  pkgs,
  lib,
  config,
  ...
}: let
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
    vim = opts: let
      cmdSet = builtins.elemAt opts 1;
      mods = builtins.elemAt opts 0;
    in
      map (key: let
        cmdMap = {
          "k" = cmdSet.up;
          "j" = cmdSet.down;
          "h" = cmdSet.left;
          "l" = cmdSet.right;
        };
      in [mods key cmdMap.${key}]) ["k" "j" "h" "l"];

    # generates binds for workspaces from 1 - 10
    # takes a list of modifiyers at index 0 and a cmd at index 1
    # which is a function that takes the number of the workspace
    # and outputs the cmd
    workspaces = opts: let
      mods = builtins.elemAt opts 0;
      cmd = builtins.elemAt opts 1;
    in (lib.concatMap
      (
        i: let
          num = toString i;
          workspaceNum =
            if i == 0
            then "10"
            else num;
        in [[mods num (cmd workspaceNum)]]
      )
      (builtins.genList (i: i) 10));
  };

  homeDir = config.home.homeDirectory;

  bins = {
    foot = lib.getExe config.programs.foot.package;
    anyrun = lib.getExe config.programs.anyrun.package;
    playerctl = lib.getExe pkgs.playerctl;
    pamixer = lib.getExe pkgs.pamixer;
    emacs = lib.getExe' config.programs.emacs.package "emacsclient";
    eww = lib.getExe config.programs.eww.package;
    swww = lib.getExe pkgs.swww;
    openrgb = lib.getExe pkgs.openrgb;
    pavucontrol = lib.getExe pkgs.pavucontrol;
  };

  scripts = {
    wall = config.home.homeDirectory + "/scripts/wall.sh"; # from ./share/wall/wall.nix
    volume = homeDir + "/.config/hypr/scripts/volume.sh"; # move out of hypr ?
    volumeEww = homeDir + "/scripts/eww/volume.sh"; # move out of eww ?
    rgb = homeDir + "/.config/hypr/scripts/rgb.sh"; # move out of hypr
    defaultSink = homeDir + "/.config/hypr/scripts/default-sink.sh"; # move out of hypr
    vm = let
      name = "ubuntu23.10";
    in {
      start = ''
        sudo virsh net-start --network default; \
        sudo virsh start ${name}; \
        virt-manager --connect qemu:///system --show-domain-console "${name}"
      '';
      stop = "sudo virsh shutdown ${name}";
    };
  };

  generator = settings: let
    inherit
      (settings.keys)
      mod
      shift
      ctrl
      alt
      print
      media
      ;

    inherit
      (settings.cmds)
      fullScreen
      exec
      killFocused
      floatingToggle
      moveFocus
      moveWindow
      resizeWindow
      workspace
      toggleBar
      focusLast
      lock
      killWM
      screenshotRegion
      screenshotScreen
      notifyLayoutSwitch
      ;

    spawners = [
      [[mod] "x" "${exec} ${bins.foot}"]
      [[mod] "r" "${exec} ${bins.anyrun}"]
      [[mod] "e" "${exec} ${bins.emacs} -c"]

      [[mod] "a" "${exec} ${scripts.wall} f"]
      [[mod shift] "a" "${exec} ${scripts.wall} b"]
      [[mod alt] "q" ''${exec} pgrep "pavucontrol" > /dev/null && pkill pavucontrol || ${bins.pavucontrol} &'']

      [[] "${print}" "${exec} ${screenshotRegion}"]
      [[shift] "${print}" "${exec} ${screenshotScreen}"]
    ];

    eww = [
      # needs ../../../gui/eww/eww
      [[mod] "s" "${exec} ${bins.eww} open board --toggle"]
      [[mod shift] "s" "${exec} pkill eww"]
      [[mod shift] "d" "${exec} ${bins.eww} open set_board --toggle"]
      [[mod] "w" "${exec} ${toggleBar}"]
      [[mod] "c" "${exec} ${bins.swww} clear"]
    ];

    virtualMachines = [
      [[mod ctrl alt] "v" "${exec} ${builtins.replaceStrings ["\n" "\\"] ["" ""] scripts.vm.start}"]
      [[mod shift ctrl alt] "v" "${exec} ${scripts.vm.stop}"]
    ];

    rgb = [
      [[mod ctrl] "a" "${exec} ${scripts.rgb}"]
      [[mod ctrl alt] "a" "${exec} ${bins.openrgb} -p black"]
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
        [[mod shift] "F12" "${exec} ${scripts.defaultSink}"]
        [[mod] "F8" "${exec} ${bins.pamixer} --default-source -t"]
      ];
    };

    window = {
      # window control
      control = let
        switchSplitOrientationOpt =
          if builtins.hasAttr "switchSplitOrientation" settings.cmds
          then [
            [[mod shift] "r" settings.cmds.switchSplitOrientation]
            [[mod shift] "p" settings.cmds.switchSplitOrientation]
          ]
          else [];
      in
        [
          [[mod] "f" fullScreen]
          [[mod shift] "q" killFocused]
          [[mod] "z" floatingToggle]
          [[alt] "TAB" focusLast]
        ]
        ++ switchSplitOrientationOpt;

      focus = helpers.vim [[mod] moveFocus];
      move = helpers.vim [[mod ctrl] moveWindow];
      resize = helpers.vim [[mod shift] resizeWindow];
    };

    workspaces = {
      focus =
        [[[mod] "grave" (workspace.focus "0")]]
        ++ (helpers.workspaces [[mod] workspace.focus]);
      move =
        [[[mod shift] "grave" (workspace.moveWindowTo "0")]]
        ++ (helpers.workspaces [[mod shift] workspace.moveWindowTo]);
    };

    system = [
      [[mod shift alt ctrl] "l" "${exec} ${lock}"]
      [[mod shift alt ctrl] "s" "${exec} ${lock} & systemctl suspend &"]
      [[mod shift alt ctrl] "q" "${killWM}"]
      [[mod] "Space" "${exec} ${notifyLayoutSwitch}"]
    ];
  in
    spawners
    ++ window.control
    ++ window.focus
    ++ window.move
    ++ window.resize
    ++ mediaControl.music
    ++ mediaControl.browser
    ++ mediaControl.system
    ++ workspaces.focus
    ++ workspaces.move
    ++ eww
    ++ virtualMachines
    ++ rgb
    ++ system;
in {
  cbinds.generate = generator;
}
