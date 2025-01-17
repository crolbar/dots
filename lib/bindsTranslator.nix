# very basic binds translator functions which let me have one global file for
# all of my binds (../home/wm/binds.nix) instead of one for each wm/compositor.
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

      river = let
        translate = bind: let
          mods = lib.concatStringsSep "+" bind.mods;
        in {"${mods} ${bind.key}" = bind.cmd;};

        # just combines the list of attr sets
        # that we get from (map translate []) into one attr set
        combine = lib.zipAttrsWith (x: y: lib.head y);
      in
        binds: combine (map translate binds);
    };
  in
    lib.getAttr wm wm_translators;
in {inherit translateBinds;}
