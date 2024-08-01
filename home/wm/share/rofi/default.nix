{config, ...}: {
  programs.rofi = {
    enable = true;
    theme = "${config.xdg.configHome}/rofi/spotlight-dark.rasi";
  };
  xdg.configFile."rofi/spotlight-dark.rasi".source = ./spotlight-dark.rasi;
}
