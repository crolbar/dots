{username, ...}: {
  services.syncthing = {
    enable = true;
    user = username;
    dataDir = "/home/${username}/.config/sycthing";
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
        "308" = {
          name = "308";
          id = "VBKUCBH-PIGMHNS-CJ6L3FZ-27MYWCH-4BH5FSN-VW67KZ7-4IR2CSG-CIL2DQP";
        };
      };

      folders = {
        projects = {
          path = "/home/${username}/projects";
          devices = ["308"];
        };

        dots = {
          path = "/home/${username}/Github/dots";
          devices = ["308"];
        };

        yo = {
          path = "/home/${username}/yo";
          devices = ["308"];
        };
      };
    };
  };
}
