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

    dump = {
      enable = true;
      type = "tar.xz";
      interval = "14:30"; # usualy this would be at night but I don't sleep at night so..
      backupDir = "/var/backups/forgejo";
      age = "2w";
    };

    settings = {
      DEFAULT = {
        APP_NAME = "git for an retart";
        RUN_USER = "forgejo";
      };

      ui = {
        DEFAULT_THEME = "forgejo-dark";
      };

      "ui.meta" = {
        AUTHOR = "";
        DESCRIPTION = "";
      };

      server = let
        protocol =
          if config.services.caddy.enable
          then "https"
          else "http";
      in rec {
        HTTP_PORT = 3000;
        PROTOCOL = "http";
        DOMAIN = "screw.rs";
        ROOT_URL = "${protocol}://${DOMAIN}/";
        ENABLE_ACME = false;
      };

      database = {
        DB_TYPE = "mysql";
        NAME = "forgejo";
        USER = "forgejo";
        PASSWD = "forgejo";
      };

      repository = {
        DISABLE_STARS = true;
        DEFAULT_PRIVATE = "public";
      };

      security = {
        LOGIN_REMEMBER_DAYS = 30;
      };

      service = {
        DISABLE_REGISTRATION = true;
      };

      metrics = {
        ENABLED = true;
        ENABLED_ISSUE_BY_REPOSITORY = true;
        ENABLED_ISSUE_BY_LABEL = true;
      };

      actions = {
        ENABLED = false;
      };

      other = {
        SHOW_FOOTER_VERSION = false;
        SHOW_FOOTER_POWERED_BY = false;
      };
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
