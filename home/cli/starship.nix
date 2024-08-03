{
  programs.starship = {
    enable = true;
    settings = {
      git_status = {
        modified = "✶";
        staged = "✓";
        stashed = "≡";
      };

      nix_shell = {
        symbol = " ";
        heuristic = true;
      };
    };
  };
}
