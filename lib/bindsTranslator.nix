# very basic binds translator functions which let me have one global file for
# all of my binds (../home/wm/share/binds/default.nix) instead of one for each wm/compositor.
#
# all it is doing is taking this for example
# [
#   [mod]
#   "x"
#   "${execCmd} ${lib.getExe config.programs.foot.package}"
# ]
#
# and translating it into the given wm's config language. (hyprland for example)
#
# "SUPER, x, exec, ${lib.getExe config.programs.foot.package}"
#
# `mod` would be set to `SUPER` and `execCmd` would be set to `exec,` (the comma is weird but it helps be stay sane)
{lib, ...}: let
  bindFromListToSet = bind: let
    mods = builtins.elemAt bind 0;
    key = builtins.elemAt bind 1;
    cmd = builtins.elemAt bind 2;
  in {inherit mods key cmd;};

  # needs to be called with `wm`(string). that is the name
  # of the window manager that has a field in `wm_translators`
  # and has to output an attr set with an function `translateBinds`
  # that takes the list of binds that I generate with `cbinds.generate`
  # and outputs the correct type and format of binds that need to be passed
  # to the home manager module for the specifiyed `wm`
  translateBinds = wm: let
    wm_translators = {
      # example what it needs to output
      # {
      #   "${mod}+Shift+x" = "exec foot";
      #   "${mod}+f" = "fullscreen toggle";
      # }
      sway = let
        translate = b: let
          bind = bindFromListToSet b;
          fmtMods = lib.concatStringsSep "+" bind.mods;
        in
          if builtins.length bind.mods > 0
          then {"${fmtMods}+${bind.key}" = bind.cmd;}
          else {"${bind.key}" = bind.cmd;};

        # just combines the list of attr sets
        # that we get from (map translate []) into one attr set
        combine = lib.zipAttrsWith (x: y: lib.head y);
      in
        binds: combine (map translate binds);

      # example what it needs to output
      # [
      #   "SUPER SHIFT, x, exec, foot"
      #
      #   "SUPER, f, fullscreen"
      # ]
      hypr = let
        translate = b: let
          bind = bindFromListToSet b;
          fmtMods = lib.concatStringsSep " " bind.mods;
        in
          if builtins.length bind.mods > 0
          then "${fmtMods}, ${bind.key}, ${bind.cmd}"
          else ", ${bind.key}, ${bind.cmd}";
      in
        binds: map translate binds;

      # example what it needs to output
      # {
      #   "Super+Shift x" = "spawn foot";
      #   "Super f" = "toggle-fullscreen";
      # }
      river = let
        translate = b: let
          bind = bindFromListToSet b;
          fmtMods = lib.concatStringsSep "+" bind.mods;
        in
          if builtins.length bind.mods > 0
          then {"${fmtMods} ${bind.key}" = "${bind.cmd}";}
          else {"None ${bind.key}" = "${bind.cmd}";};

        # just combines the list of attr sets
        # that we get from (map translate []) into one attr set
        combine = lib.zipAttrsWith (x: y: lib.head y);
      in
        binds: combine (map translate binds);

      # example what it needs to output
      # {
      #   "super + x" = "alacritty";
      #   "super + f" = "bspc node -t fullscreen";
      # }
      bsp = let
        translate = b: let
          bind = bindFromListToSet b;
          fmtMods = lib.concatStringsSep " + " bind.mods;
        in
          if builtins.length bind.mods > 0
          then {"${fmtMods} + ${bind.key}" = "${bind.cmd}";}
          else {"${bind.key}" = "${bind.cmd}";};

        # just combines the list of attr sets
        # that we get from (map translate []) into one attr set
        combine = lib.zipAttrsWith (x: y: lib.head y);
      in
        binds: combine (map translate binds);

      # example what it needs to output
      #[
      #  { command = "Execute"; value = "alacritty"; modifier = ["modkey"]; key = "x"; }
      #  { command = "ToggleFullScreen"; modifier = ["modkey"]; key = "f"; }
      #]
      leftwm = let
        translate = b: let
          bind = bindFromListToSet b;
          mods =
            if builtins.isString bind.mods
            then bind.mods
            else if builtins.length bind.mods < 1
            then []
            else bind.mods;
        in
          # with some commands it is possible that they will require
          # an value field, so when they do `bind.cmd` will be a list with [cmd value]
          # else it will be just the cmd as a string
          if builtins.isList bind.cmd
          then let
            command = builtins.elemAt bind.cmd 0;
            value = builtins.elemAt bind.cmd 1;
          in {
            inherit value command;
            modifier = mods;
            key = bind.key;
          }
          else {
            command = bind.cmd;
            modifier = mods;
            key = bind.key;
          };
      in
        binds: map translate binds;

      # example what it needs to output
      # {
      #   "${modifier}+Shift+x" = "exec foot";
      #   "${modifier}+f" = "fullscreen toggle";
      # }
      i3 = let
        translate = b: let
          bind = bindFromListToSet b;
          fmtMods = lib.concatStringsSep "+" bind.mods;
        in
          if builtins.length bind.mods > 0
          then {"${fmtMods}+${bind.key}" = bind.cmd;}
          else {"${bind.key}" = bind.cmd;};

        # just combines the list of attr sets
        # that we get from (map translate []) into one attr set
        combine = lib.zipAttrsWith (x: y: lib.head y);
      in
        binds: combine (map translate binds);

      # example what it needs to output
      # {
      #   "${modifier}+Shift+x".action.spawn = "foot";
      #   "${modifier}+f".action.fullscreen-window = {};
      # }
      niri = let
        translate = b: let
          # the name of the field in the action attrset
          # will be the first item in the cmd set
          bind = bindFromListToSet b;
          fmtMods = lib.concatStringsSep "+" bind.mods;

          # mods + keys
          name =
            if builtins.length bind.mods > 0
            then "${fmtMods}+${bind.key}"
            else bind.key;
        in
          if builtins.isList bind.cmd
          then let
            action = builtins.elemAt bind.cmd 0;
            args = builtins.elemAt bind.cmd 1;
          in {
            "${name}".action.${action} = args;
          }
          else {
            "${name}".action."${bind.cmd}" = {};
          };

        combine = lib.zipAttrsWith (x: y: lib.head y);
      in
        binds: combine (map translate binds);
    };
  in
    lib.getAttr wm wm_translators;
in {inherit translateBinds;}
