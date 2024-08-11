{
  programs.zsh = {
    enable = true;

    shellInit = ''
      bindkey -v
      setopt PROMPT_SUBST        # enable command substitution in prompt
      setopt MENU_COMPLETE       # Automatically highlight first element of completion menu

      zstyle ':completion:*' verbose true
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d"
      zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS} 'ma=48;5;197;1'
      zstyle ':completion:*:descriptions' format "%F{yellow}[-- %d --]%f"
    '';

    syntaxHighlighting = {
      enable = true;
      patterns = {"rm -rf *" = "fg=black,bg=red";};
      highlighters = ["brackets" "pattern"];
    };
  };
}
