{pkgs, ...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.foot}/bin/foot";
        layer = "overlay";
        match-counter = true;
      };
      colors = {
        background = "303030ee";
        text = "ebdbb2ff";
        message = "ebdbb2ff";
        prompt = "ebdbb2ff";
        placeholder = "ebdbb2ff";
        input = "ebdbb2ff";
        match = "ebdbb2ff";
        selection = "504945ff";
        selection-text = "ebdbb2ff";
        selection-match = "ebdbb2ff";
        counter = "ebdbb2ff";
        border = "252525ff";
      };
    };
  };
}
