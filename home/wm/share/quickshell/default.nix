{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    quickshell
    kdePackages.qtdeclarative
  ];

  systemd.user.services.quickshell = {
    Unit = {
      Description = "Quickshell";
      After = [config.wayland.systemd.target];
      PartOf = [config.wayland.systemd.target];
    };

    Service = {
      Type = "exec";
      ExecStart = "${lib.getExe pkgs.quickshell}";
      Restart = "on-failure";
      RestartSec = "5s";
      TimeoutStopSec = "5s";
      Environment = ["QT_QPA_PLATFORM=wayland"];

      Slice = "session.slice";
    };

    Install = {
      WantedBy = [config.wayland.systemd.target];
    };
  };

  # currently doing a plain `ln -s ~/Github/dots/home/wm/share/quickshell/shell ~/.config/quickshell`
  # xdg.configFile."quickshell".source = ./shell;
}
