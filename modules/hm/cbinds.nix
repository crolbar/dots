{
  lib,
  config,
  clib,
  ...
}: {
  options.cbinds = let
    inherit (lib) types mkOption mkOptionType;
  in {
    generate = let
      bind = let
        isBind = bind: let
          bindScheme = {
            mods = b: (builtins.elemAt b 0);
            key = b: (builtins.elemAt b 1);
            cmd = b: (builtins.elemAt b 2);
          };
        in
          ((lib.length bind) == 3)
          && (builtins.isList (bindScheme.mods bind))
          && (builtins.isString (bindScheme.key bind))
          && (
            (builtins.isString (bindScheme.cmd bind))
            || (builtins.isList (bindScheme.cmd bind))
          );
      in
        mkOptionType {
          name = "bind";
          description = ''example: [["Super"] "x" "exec alacritty"]'';
          check = isBind;
        };
    in
      mkOption {
        type = types.functionTo (types.listOf bind);
        default = s: [];
        description = ''
          Function that takes `cbinds.windowManager.*.settings`
          and outputs a list of `bind`
        '';
        example = settings: let
          inherit (settings.keys) mod;
          inherit (settings.cmds) exec;
        in [
          [[mod] "x" "${exec} alacritty"]
        ];
      };

    windowManager = mkOption {
      example = {
        cbinds.windowManager."<wm name>" = {
          settings = {};
        };
      };
      type = types.attrsOf (types.submodule {
        options = {
          settings = mkOption {
            type = types.attrs;
            description = ''
              attr set that is going to be passed into `generate`
              can be used for variables between window managers for example
              the mod key, fullscreen command..
            '';
            example = {
              keys = {
                mod = config.wayland.windowManager.sway.config.modifier;
                shift = "Shift";
                ctrl = "Ctrl";
                alt = "Alt";
              };

              cmds = {
                fullScreen = "fullscreen toggle";
                exec = "exec";
                killFocused = "kill";
                floatingToggle = "floating toggle";
                workspace = {
                  focus = num: "workspace number ${num}";
                  moveWindowTo = num: "move container to workspace number ${num}";
                };
              };
            };
          };
        };
      });
    };
  };

  config = let
    cfg = config.cbinds;
    gen = wm:
      (clib.translateBinds wm)
      (cfg.generate cfg.windowManager.${wm}.settings);
  in {
    wayland.windowManager.sway.config.keybindings = gen "sway";
    wayland.windowManager.hyprland.settings.bind = lib.mkIf config.wayland.windowManager.hyprland.enable (gen "hypr");
    wayland.windowManager.river.settings.map.normal = gen "river";
    services.sxhkd.keybindings = gen "bsp";
    programs.leftwm.settings.keybind = gen "leftwm";
    xsession.windowManager.i3.config.keybindings = gen "i3";
    programs.niri.settings.binds = lib.mkIf config.programs.niri.enable (gen "niri");
  };
}
