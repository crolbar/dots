{
  programs.zsh = {
    enable = true;
    syntaxHighlighting = {
      enable = true;
      patterns = {"rm -rf *" = "fg=black,bg=red";};
      highlighters = ["brackets" "pattern"];
    };
  };
}
