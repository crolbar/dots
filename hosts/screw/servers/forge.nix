{
  config,
  pkgs,
  lib,
  ...
}: {
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

  environment.systemPackages = let
    cfg = config.services.forgejo;
  in [
    (pkgs.writeScriptBin "forgejo-cli" ''
      #!${pkgs.runtimeShell}
      cd ${cfg.stateDir}
      exec=exec
      if [[ "$USER" != ${cfg.user} ]]; then
        exec='exec /run/wrappers/bin/sudo -u ${cfg.user} -g ${cfg.group} --preserve-env=GITEA_WORK_DIR --preserve-env=GITEA_CUSTOM'
      fi
      export GITEA_WORK_DIR=${cfg.stateDir}
      export GITEA_CUSTOM=${cfg.customDir}
      $exec ${lib.getExe cfg.package} "$@"
    '')
  ];
}
