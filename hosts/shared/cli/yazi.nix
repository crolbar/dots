{
  pkgs,
  lib,
  ...
}: {
  environment = {
    defaultPackages = with pkgs; [
      _7zz
      ueberzugpp
    ];

    shellInit = ''
      function yy() {
          local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
          yazi "$@" --cwd-file="$tmp"
          if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
              builtin cd -- "$cwd"
          fi
          rm -f -- "$tmp"
      }
    '';
  };

  programs.yazi = {
    enable = true;

    settings = {
      yazi = {
        mgr = {
          show_hidden = true;
          linemode = "size";
        };

        opener = {
          view = [
            {
              run = ''${lib.getExe pkgs.feh} "$0"'';
              block = false;
              orphan = true;
              desc = "View";
            }
          ];
          edit_img = [
            {
              run = ''${lib.getExe pkgs.gimp} "$0"'';
              block = false;
              orphan = true;
              desc = "Edit";
            }
          ];
          set_as_wall = [
            {
              run = ''${lib.getExe pkgs.awww} img "$0"'';
              desc = "SetAsWall";
            }
          ];
          set_as_wall_fit = [
            {
              run = ''${lib.getExe pkgs.awww} img "$0" --resize fit'';
              desc = "SetAsWallFit";
            }
          ];
          run_sh = [
            {
              run = ''${lib.getExe pkgs.bash} "$1"'';
              desc = "RunSh";
              orphan = true;
            }
          ];
          steam_run_sh = [
            {
              run = ''nohup setsid ${lib.getExe pkgs.steam-run} "$1" >/dev/null'';
              desc = "SteamRunSh";
              orphan = true;
              block = false;
            }
          ];
        };

        open = {
          rules = [
            {
              mime = "text/plain";
              use = ["edit" "open" "reveal"];
            }
            {
              mime = "text/shellscript";
              use = ["edit" "run_sh" "steam_run_sh" "reveal"];
            }
            {
              mime = "image/*";
              use = ["open" "set_as_wall" "set_as_wall_fit" "edit_img" "reveal"];
            }
            {
              mime = "{audiovideo}/*";
              use = ["play" "open" "reveal"];
            }

            {
              mime = "application/*zip";
              use = ["extract" "open" "reveal"];
            }
            {
              mime = "application/x-{tarbzip*7z-compressedxzrar}";
              use = ["extract" "open" "reveal"];
            }

            {
              mime = "inode/x-empty";
              use = ["edit" "reveal"];
            }
            {
              mime = "*";
              use = ["open" "reveal"];
            }
          ];
        };
      };

      keymap = {
        input.prepend_keymap = [
          {
            on = "<Esc>";
            run = "close";
            desc = "Cancel input";
          }
        ];
      };
    };
  };
}
