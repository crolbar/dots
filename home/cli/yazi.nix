{
  yazi,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;

    package = yazi.packages.${pkgs.system}.default;

    settings = {
      manager = {
        show_hidden = true;
        linemode = "size";
      };

      opener = {
        view = [
          {
            run = ''feh "$0"'';
            block = false;
            orphan = true;
            desc = "View";
          }
        ];
        edit_img = [
          {
            run = ''gimp "$0"'';
            block = false;
            orphan = true;
            desc = "edit";
          }
        ];
        set_as_wall = [
          {
            run = ''pkill swaybg ; swaybg -i "$0" -m fit'';
            block = false;
            orphan = true;
            desc = "SetAsWall";
          }
        ];
      };

      open = {
        rules = [
          {
            name = "*/";
            use = ["edit" "open" "reveal"];
          }

          {
            mime = "text/*";
            use = ["edit" "reveal"];
          }
          {
            mime = "image/*";
            use = ["view" "set_as_wall" "edit_img" "reveal"];
          }
          {
            mime = "{audiovideo}/*";
            use = ["play" "reveal"];
          }

          {
            mime = "application/*zip";
            use = ["extract" "reveal"];
          }
          {
            mime = "application/x-{tarbzip*7z-compressedxzrar}";
            use = ["extract" "reveal"];
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
  };
}
