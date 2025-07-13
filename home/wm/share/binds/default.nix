{
  pkgs,
  lib,
  config,
  clib,
  ...
}: let
  generator = settings: let
    binds = {
      spawners = let
        runner =
          if has "isX11" settings
          then "${bins.rofi} -show drun -show-icons"
          else bins.anyrun;

        term =
          if has "isX11" settings
          then bins.alacritty
          else bins.ghostty;

        toggleVolControl = exec ''pgrep pavucontrol > /dev/null && pkill pavucontrol || ${bins.pavucontrol} &'';
      in [
        [[mod] "x" (exec term)]
        [[mod] "r" (exec runner)]
        [[mod] "e" (exec "${bins.emacs} -c")]

        [[mod] "a" (exec "${scripts.wall} f")]
        [[mod shift] "a" (exec "${scripts.wall} b")]
        [[mod] "c" (exec "${bins.swww} clear")]

        [[mod alt] "q" toggleVolControl]

        [[] "${print}" (exec screenshotRegion)]
        [[shift] "${print}" (exec screenshotScreen)]
      ];

      eww = [
        # needs ../../../gui/eww/eww
        [[mod] "s" (exec "${bins.eww} open board --toggle")]
        [[mod shift] "s" (exec "pkill eww")]
        [[mod shift] "d" (exec "${bins.eww} open set_board --toggle")]
        [[mod] "w" (exec toggleBar)]
      ];

      virtualMachines = let
        startVm = exec ''bash -c "${clib.mk1lnrCmd scripts.vm.start}"'';
        stopVm = exec "${scripts.vm.stop}";
      in [
        [[mod ctrl alt] "v" startVm]
        [[mod shift ctrl alt] "v" stopVm]
      ];

      rgb = [
        [[mod ctrl] "a" (exec "${scripts.rgb}")]
        [[mod ctrl alt] "a" (exec "${bins.openrgb} -p black")]
      ];

      mediaControl = {
        # music player defined in ../scripts/default.nix
        music = [
          [[mod shift alt] "F11" (exec "${scripts.volume} md")]
          [[mod shift alt] "F12" (exec "${scripts.volume} mu")]
          [[mod shift alt] "F7" (exec "${scripts.volumeEww} music mute")]
        ];

        # (browser defined in ../scripts/default.nix)
        browser = [
          [[mod shift alt] "F9" (exec "${scripts.volume} bd")]
          [[mod shift alt] "F10" (exec "${scripts.volume} bu")]
          [[mod shift alt] "F8" (exec "${scripts.volumeEww} browser mute")]
        ];

        system = [
          [[] media.play (exec "${bins.playerctl} play-pause")]
          [[] media.next (exec "${bins.playerctl} next")]
          [[] media.prev (exec "${bins.playerctl} previous")]
          [[] media.lowerVolume (exec "${bins.pamixer} -d 5")]
          [[] media.raiseVolume (exec "${bins.pamixer} -i 5")]
          [[mod shift] "F12" (exec "${scripts.defaultSink}")]
          [[mod] "F8" (exec "${bins.pamixer} --default-source -t")]
          [[mod] "F9" (exec "${bins.pamixer} -t")]
        ];
      };

      window = {
        # window control
        control = let
          switchSplitOrientation = helpers.mkOptionalBinds settings [
            [[mod shift] "r" "switchSplitOrientation"]
            [[mod shift] "p" "switchSplitOrientation"]
          ];
          switchLayout = helpers.mkOptionalBinds settings [
            [[mod] "t" "switchLayoutTabbed"]
          ];
        in
          [
            [[mod] "f" fullScreen]
            [[mod shift] "q" killFocused]
            [[mod] "z" floatingToggle]
            [[alt] tab focusLast]
          ]
          ++ switchSplitOrientation
          ++ switchLayout;

        focus = helpers.vim [[mod] moveFocus];
        move = helpers.vim [[mod ctrl] moveWindow];
        resize = helpers.vim [[mod shift] resizeWindow];

        wheelFocus =
          if (has "isNiri" settings)
          then [
            [[mod] wheel.up moveFocus.up]
            [[mod] wheel.down moveFocus.down]
            [[mod shift] wheel.down moveFocus.right]
            [[mod shift] wheel.up moveFocus.left]
          ]
          else [];
      };

      workspaces = {
        focus =
          [[[mod] "grave" (workspace.focus "0")]]
          ++ (helpers.workspaces [[mod] workspace.focus]);
        move =
          [[[mod shift] "grave" (workspace.moveWindowTo "0")]]
          ++ (helpers.workspaces [[mod shift] workspace.moveWindowTo]);
      };

      system =
        [
          [[mod shift alt ctrl] "l" (exec lock)]
          [[mod shift alt ctrl] "s" (exec "${lock} & systemctl suspend &")]
          [[mod shift alt ctrl] "q" killWM]
          [[mod] space (exec notifyLayoutSwitch)]
        ]
        ++ helpers.mkOptionalBinds settings [
          [[mod ctrl] "r" "refreshBinds"]
        ];

      # not used only by river
      river = helpers.mkOptionalBinds settings (import ./river.nix settings);
    };

    inherit
      (settings.keys)
      mod
      shift
      ctrl
      alt
      print
      media
      tab
      space
      wheel
      ;

    inherit
      (settings.cmds)
      fullScreen
      killFocused
      floatingToggle
      moveFocus
      moveWindow
      resizeWindow
      workspace
      focusLast
      killWM
      ;

    inherit
      (settings.cmds.bin)
      toggleBar
      lock
      notifyLayoutSwitch
      screenshotRegion
      screenshotScreen
      ;

    inherit (helpers) has;

    # apparently hyprland does not like quotes after exec,
    # also sxhkd has a problem with single quotes...
    exec = shellCmd:
      if has "isHyprland" settings || has "isBsp" settings
      then "${settings.cmds.exec} ${shellCmd}"
      else if has "isI3" settings
      then "${settings.cmds.exec} \"${helpers.fixI3 shellCmd}\""
      else if has "isLeft" settings
      then [settings.cmds.exec (helpers.escapeQuotes shellCmd)] # escaping because `value` is wrapped with double quotes
      else if has "isNiri" settings
      then [settings.cmds.exec ["sh" "-c" shellCmd]]
      else "${settings.cmds.exec} '${shellCmd}'";
  in
    helpers.concatBinds binds;

  helpers = import ./helpers.nix lib;

  bins = {
    foot = lib.getExe config.programs.foot.package;
    ghostty = lib.getExe config.programs.ghostty.package;
    alacritty = lib.getExe config.programs.alacritty.package;

    anyrun = lib.getExe config.programs.anyrun.package;
    rofi = lib.getExe config.programs.rofi.package;

    playerctl = lib.getExe pkgs.playerctl;
    pamixer = lib.getExe pkgs.pamixer;

    emacs = lib.getExe' config.programs.emacs.package "emacsclient";

    eww = lib.getExe config.programs.eww.package;
    swww = lib.getExe pkgs.swww;

    openrgb = lib.getExe pkgs.openrgb;
    pavucontrol = lib.getExe pkgs.pavucontrol;
  };

  scripts = let
    # getScriptPath
    gSP = path: config.home.file."${path}".source;
  in {
    wall = gSP "scripts/wall.sh";
    volume = gSP "scripts/volume";
    volumeEww = gSP "scripts/eww/volume.sh";
    rgb = gSP "scripts/rgb.sh";
    defaultSink = gSP "scripts/default-sink.sh";
    vm = let
      name = "ubuntu23.10";
      virsh = lib.getExe' pkgs.libvirt "virsh";
      virt-manager = lib.getExe pkgs.virt-manager;
    in {
      start = ''
        sudo ${virsh} net-start --network default; \
        sudo ${virsh} start ${name}; \
        ${virt-manager} --connect qemu:///system --show-domain-console "${name}"
      '';
      stop = "sudo ${virsh} shutdown ${name}";
    };
  };
in {
  cbinds.generate = generator;
}
