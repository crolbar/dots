{
  lib,
  config,
  username,
  ...
}: let
  inherit (lib) types mkOption mkIf;
  cfg = config.syncthing;
in {
  options.syncthing = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    settings = {
      gui = {
        enabled = mkOption {
          type = types.bool;
          default = false;
        };

        password = mkOption {
          type = types.str;
          default = "";
        };
      };

      devices = mkOption {
        type = types.attrs;
        default = {};
      };

      folders = mkOption {
        default = {};
        type = types.attrsOf (types.submodule {
          options = {
            path = mkOption {
              type = types.str;
            };
            devices = mkOption {
              type = types.listOf types.str;
            };
            ignores = mkOption {
              type = types.listOf types.str;
              default = [];
            };
          };
        });
      };
    };
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = username;
      dataDir = "/home/${username}/.config/sycthing";
      configDir = "/home/${username}/.config/syncthing";

      settings = {
        gui = {
          enabled = cfg.settings.gui.enabled;

          user = username;
          password = cfg.settings.gui.password;
        };

        options.urAccepted = -1;

        inherit (cfg.settings) folders devices;
      };
    };

    home-manager.users.${username}.imports = [
      {
        home.file =
          lib.concatMapAttrs (
            _: {
              path,
              ignores,
              ...
            }:
              if ignores == []
              then {}
              else {"${path}/.stignore".text = builtins.concatStringsSep "\n" ignores;}
          )
          cfg.settings.folders;
      }
    ];
  };
}
