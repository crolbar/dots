{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    theme = "${config.xdg.configHome}/rofi/spotlight-dark.rasi";
    terminal = "${pkgs.alacritty}/bin/alacritty";
  };
  xdg.configFile."rofi/spotlight-dark.rasi".source = ./spotlight-dark.rasi;
}
