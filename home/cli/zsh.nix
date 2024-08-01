{...}: {
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";

    history = {
      path = "$HOME/.config/zsh/zsh_history";
      ignorePatterns = ["t"];
    };

    autocd = true;

    initExtraFirst = ''
      setopt PROMPT_SUBST        # enable command substitution in prompt
      setopt MENU_COMPLETE       # Automatically highlight first element of completion menu

      zstyle ':completion:*' verbose true
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list ''' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
      zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d"
      zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS} 'ma=48;5;197;1'
      zstyle ':completion:*:descriptions' format "%F{yellow}[-- %d --]%f"

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


      autoload -Uz vcs_info
      zstyle ':vcs_info:*' formats ' %B%s-[%F{yellow}%f %F{white}%b%f]-'
      precmd () { vcs_info }

      # prompt
      PROMPT=' %B%F{red}%~%f%b''${vcs_info_msg_0_}%b %(?.%B%F{green}✓.%F{red}✕)%f%b %B%F{green}>%f%b '

      neofetch
    '';
  };
}
