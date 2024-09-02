{pkgs, ...}: {
  home.packages = [pkgs.way-displays];

  # https://github.com/alex-courtis/way-displays/wiki/Configuration#arrange-and-align
  xdg.configFile."way-displays/cfg.yaml".text = ''
    ARRANGE: ROW
    ALIGN: TOP

    CHANGE_SUCCESS_CMD: 'dunstify way-displays "Monitor changed"'

    SCALING: TRUE
    AUTO_SCALE: TRUE
    AUTO_SCALE_MIN: 1.0
    AUTO_SCALE_MAX: 2.5

    SCALE:
      - NAME_DESC: eDP-1
        SCALE: 2

    MODE:
      - NAME_DESC: eDP-1
        WIDTH: 3200
        HEIGHT: 2000
        HZ: 120
  '';
}
