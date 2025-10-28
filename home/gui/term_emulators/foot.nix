{
  programs.foot = {
    enable = true;
    settings = {
      colors = rec {
        alpha = 0.8;
        foreground = "ffffff"; # Text
        background = "000000"; # Base

        ## Bright colors (color palette 8-15)
        bright0 = "393939"; # bright black
        bright1 = "ee5396"; # bright red
        bright2 = "42be65"; # bright green
        bright3 = "ffe97b"; # bright yellow
        bright4 = "33b1ff"; # bright blue
        bright5 = "ff7eb6"; # bright magenta
        bright6 = "3ddbd9"; # bright cyan
        bright7 = "ffffff"; # bright white

        # Normal/regular colors (color palette 0-7)
        regular0 = "000000"; # black
        regular1 = "ff7eb6"; # red
        regular2 = "42be65"; # green
        regular3 = "ffe97b"; # yellow
        regular4 = "33b1ff"; # blue
        regular5 = "ff7eb6"; # magenta
        regular6 = "3ddbd9"; # cyan
        regular7 = "dde1e6"; # white

        selection-background = "525252";
        selection-foreground = regular7;

        cursor = "000000 ff7eb6";
      };

      main = {
        font = "Hack:size=10";
        selection-target = "clipboard";
      };
    };
  };
}
