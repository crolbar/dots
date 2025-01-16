# very basic binds translator functions which let me have one global file for
# all of my binds (../home/wm/binds.nix) instead of one for each wm/compositor.
#
# all it is doing is taking this for example
# {
#   mods = [mod];
#   key = "x";
#   cmd = "${execCmd} ${lib.getExe config.programs.foot.package}";
# }
#
# and translating it into the given wm's config lang. (hyprland for example)
#
# "SUPER, x, exec, ${lib.getExe config.programs.foot.package}"
#
# `mod` would be set to `SUPER` and `execCmd` would be set to `exec,` (the comma is weird but it helps be stay sane)
#
#
#
# needs to be called with `wm`(string). that is the name
# of the window manager that is an field in `wm_translaters`
# also with `settings` which is an attr set which fields are passed
# to `../home/wm/binds.nix` for the help with variables between WMs like mod key
{
  lib,
  wm,
  ...
} @ attrs: let
  wm_translaters = {
    sway = let
      translate = bind: let
        key = builtins.elemAt bind 1;
        cmd = builtins.elemAt bind 2;

        mods = lib.concatStringsSep "+" (builtins.elemAt bind 0);
      in {"${mods}+${key}" = cmd;};

      # just combines the list of attr sets
      # that we get from (map translate []) into one attr set
      combine = lib.zipAttrsWith (x: y: lib.head y);

      translateBinds = binds: combine (map translate binds);
    in
      translateBinds;

    hypr = let
      translate = bind: let
        mods = lib.concatStringsSep " " bind.mods;
      in "${mods}, ${bind.key}, ${bind.cmd}";

      translateBinds = binds: map translate binds;
    in
      translateBinds;

    river = let
      translate = bind: let
        mods = lib.concatStringsSep "+" bind.mods;
      in {"${mods} ${bind.key}" = bind.cmd;};

      # just combines the list of attr sets
      # that we get from (map translate []) into one attr set
      combine = lib.zipAttrsWith (x: y: lib.head y);

      translateBinds = binds: combine (map translate binds);
    in
      translateBinds;
  };

  translateBinds = lib.getAttr wm wm_translaters;
in
  translateBinds (import ../home/wm/binds.nix attrs)
