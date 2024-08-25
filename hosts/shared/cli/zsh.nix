{
  programs.zsh = {
    enable = true;

    shellInit = ''
      bindkey -v

      # Ctrl + right
      bindkey '^[[1;5C' forward-word
      # Ctrl + left
      bindkey '^[[1;5D' backward-word

      # Ctrl + BS
      bindkey '^H' backward-kill-word
      bindkey '^W' backward-kill-word

      # Ctrl + del
      bindkey '^[[3;5~' kill-word

      # Shift + tab in complete
      bindkey '^[[Z' reverse-menu-complete

      ## vim delte char bug
      bindkey "^?" backward-delete-char

      # edit cmd line with $EDITOR
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey "^E" edit-command-line
      bindkey -M vicmd "^E" edit-command-line

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
