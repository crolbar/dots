{username, ...}: {
  services.syncthing = {
    enable = true;
    user = username;
    dataDir = "/home/${username}/.config/syncthing";
    configDir = "/home/${username}/.config/syncthing";

    settings = {
      gui = {
        # if changed to false the service needs to be manualy restarted
        #
        # then when changing it back on before rebuilding
        # the gui needs to be manualy enabled from the config.xml and then
        # the service again needs to be manualy restarted
        enabled = true;

        user = username;
        password = "$2y$10$U7shaPruuGWsJPaZu1e1oukhiRmmBJfkxqDB249tfng/apPmjhg.C";
      };
      options = {
        urAccepted = -1;
      };

      devices = {
        "plier" = {
          name = "plier";
          id = "2G47DGH-DCVJPJG-CPMUZLQ-NAW33W5-MWNVB5R-A7RVNYZ-6NXPGYS-JHOESAM";
        };
      };

      folders = {
        projects = {
          path = "/home/${username}/projects";
          devices = ["plier"];
        };

        dots = {
          path = "/home/${username}/Github/dots";
          devices = ["plier"];
        };

        yo = {
          path = "/home/${username}/yo";
          devices = ["plier"];
        };
      };
    };
  };
}
