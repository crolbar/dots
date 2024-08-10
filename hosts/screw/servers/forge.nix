{...}: {
  services.forgejo = {
    enable = true;
    database.type = "mysql";

    lfs.enable = true;

    settings = {
      DEFAULT.APP_NAME = "git for an retart";
      database = {
        DB_TYPE = "mysql";
        NAME = "forgejo";
        USER = "forgejo";
        PASSWD = "forgejo";
      };

      server = {
        DOMAIN = "screw";
        ROOT_URL = "http://screw.s/";
        HTTP_PORT = 3000;
      };

      repository = {
        DISABLE_STARS = true;
        DEFAULT_PRIVATE = "public";
      };

      service.DISABLE_REGISTRATION = true;
    };
  };
}
