{...}: let
  user = "screw";
  codeDir = "/home/${user}/code-server";
in {
  services.code-server = {
    enable = true;
    disableTelemetry = true;
    disableUpdateCheck = true;
    disableWorkspaceTrust = true;
    hashedPassword = "$argon2i$v=19$m=4096,t=3,p=1$bnhEakNZa2MwT0owUjBWaDBobDd3L1U2MGN3PQ$4KfmwaXQInM2e9XTT7aGECVwPGbAOxQSfHpz+mLx93E";
    port = 4444;
    user = user;
    extraArguments = [
      "--config"
      "${codeDir}/.code-config.yaml"
      "--extensions-dir"
      "${codeDir}/.code-extensions"

      "${codeDir}"
    ];
    userDataDir = "${codeDir}/.code-data";
    extraEnvironment = {
      XDG_CONFIG_HOME = "${codeDir}/.config";
      XDG_DATA_HOME = "${codeDir}/.local/share";
      XDG_CACHE_HOME = "${codeDir}/.cache";
    };
  };
  systemd.tmpfiles.rules = [
    "d ${codeDir} 0700 ${user} users -"
  ];
}
