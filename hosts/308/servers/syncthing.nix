{username, ...}: {
  syncthing = {
    enable = true;

    settings = {
      gui = {
        # if changed to false the service needs to be manualy restarted
        #
        # then when changing it back on before rebuilding
        # the gui needs to be manualy enabled from the config.xml and then
        # the service again needs to be manualy restarted
        enabled = true;

        password = "$2y$10$U7shaPruuGWsJPaZu1e1oukhiRmmBJfkxqDB249tfng/apPmjhg.C";
      };

      devices = {
        plier = {
          name = "plier";
          id = "2G47DGH-DCVJPJG-CPMUZLQ-NAW33W5-MWNVB5R-A7RVNYZ-6NXPGYS-JHOESAM";
        };
      };

      folders = {
        projects = {
          path = "/home/${username}/projects";
          devices = ["plier"];
          ignores = [
            "target"
            "dist"
            "yuki.bin"
            "yuki_right.bin"
            "yuki_left.bin"
            "build"
            "nixos-sd-image-24.11.20240804.cb9a96f-aarch64-linux.img"
          ];
        };

        dots = {
          path = "/home/${username}/Github/dots";
          devices = ["plier"];
          ignores = ["test"];
        };

        yo = {
          path = "/home/${username}/yo";
          devices = ["plier"];
        };
      };
    };
  };
}
