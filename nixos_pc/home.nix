{
  pkgs,
  yazi,
  ...
}: {
  home.stateVersion = "23.11";
  home.username = "crolbar";
  home.homeDirectory = "/home/crolbar";
  programs.home-manager.enable = true;

  programs.yazi = {
    enable = true;

    package = yazi.packages.${pkgs.system}.default;

    settings = {
      manager = {
        show_hidden = true;
        linemode = "size";
      };

      opener = {
        view = [
          {
            run = ''feh "$0"'';
            block = false;
            orphan = true;
            desc = "View";
          }
        ];
        edit_img = [
          {
            run = ''gimp "$0"'';
            block = false;
            orphan = true;
            desc = "edit";
          }
        ];
        set_as_wall = [
          {
            run = ''pkill swaybg ; swaybg -i "$0" -m fit'';
            block = false;
            orphan = true;
            desc = "SetAsWall";
          }
        ];
      };

      open = {
        rules = [
          {
            name = "*/";
            use = ["edit" "open" "reveal"];
          }

          {
            mime = "text/*";
            use = ["edit" "reveal"];
          }
          {
            mime = "image/*";
            use = ["view" "set_as_wall" "edit_img" "reveal"];
          }
          {
            mime = "{audiovideo}/*";
            use = ["play" "reveal"];
          }

          {
            mime = "application/*zip";
            use = ["extract" "reveal"];
          }
          {
            mime = "application/x-{tarbzip*7z-compressedxzrar}";
            use = ["extract" "reveal"];
          }

          {
            mime = "inode/x-empty";
            use = ["edit" "reveal"];
          }
          {
            mime = "*";
            use = ["open" "reveal"];
          }
        ];
      };
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";

    history = {
      path = "$HOME/.config/zsh/zsh_history";
      ignorePatterns = ["t"];
    };

    autocd = true;

    initExtra = ''
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

    shellAliases = {
      ls = "lsd -a --group-directories-first";
      ll = "lsd -la --group-directories-first";

      cdd = "cd ..";
      vim = "nvim";
      vimc = "cd ~/.config/nvim && nvim .";

      ns = "nix-shell";

      mnas = "sudo mount -t nfs 192.168.1.11:/nas /mnt/nas -o rw -o async";
      umnas = "sudo umount /mnt/nas";
      nas = "cd /mnt/nas";

      t = "tmux";

      n = "cd ~/.config/nixos && vim .";

      reb = "sudo nixos-rebuild switch --flake /home/crolbar/.config/nixos#crolbar";
      hreb = "home-manager switch --flake /home/crolbar/.config/nixos#crolbar";
    };
  };
}
