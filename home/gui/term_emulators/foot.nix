{
  programs.foot = {
    enable = true;
    settings = {
      colors-dark = rec {
        alpha = 0.8;
        foreground = "ebdbb2"; # Text
        background = "282828"; # Base

        ## Bright colors (color palette 8-15)
        bright0 = "504945"; # bright black
        bright1 = "fb4934"; # bright red
        bright2 = "b8bb26"; # bright green
        bright3 = "fabd2f"; # bright yellow
        bright4 = "83a598"; # bright blue
        bright5 = "d3869b"; # bright magenta
        bright6 = "8ec07c"; # bright cyan
        bright7 = "fbf1c7"; # bright white

        # Normal/regular colors (color palette 0-7)
        regular0 = "3c3836"; # black
        regular1 = "cc241d"; # red
        regular2 = "98971a"; # green
        regular3 = "d79921"; # yellow
        regular4 = "458588"; # blue
        regular5 = "b16286"; # magenta
        regular6 = "689d6a"; # cyan
        regular7 = "ebdbb2"; # white

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
