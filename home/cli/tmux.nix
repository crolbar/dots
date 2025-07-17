{
  pkgs,
  lib,
  config,
  ...
}: let
  gitFrontend = lib.getExe config.programs.lazygit.package;
  fileExplorer = lib.getExe config.programs.yazi.package;

  gitScript = let
    session-name = "__git";
  in
    pkgs.writers.writeBash "git.sh" ''
      if ! tmux has-session -t ${session-name} 2>/dev/null; then
          tmux new-session -d -s ${session-name} -c "$(tmux display-message -p '#{pane_current_path}')" "${gitFrontend}; ${lib.getExe pkgs.zsh}"
          tmux switch-client -t ${session-name}
      elif [ "$(tmux display-message -p '#S')" == "${session-name}" ]; then
          tmux switch-client -l
      else
          if [ "$(tmux display-message -p '#{pane_current_path}')" != "$(tmux display-message -t ${session-name} -p '#{pane_current_path}')" ]; then
              tmux kill-session -t ${session-name}
              tmux new-session -d -s ${session-name} -c "$(tmux display-message -p '#{pane_current_path}')" "${gitFrontend}; ${lib.getExe pkgs.zsh}"
          fi
          tmux switch-client -t ${session-name}
      fi
    '';

  mkPopupSession = session-name: command:
    pkgs.writers.writeBash "${session-name}.sh" ''
      client=$(tmux list-clients | grep 'tmux' | cut -d: -f1)

      # popup is open; close it
      if [ "$client" ]; then
          tmux detach-client -t "$client"
          exit
      fi

      session="${session-name}"

      if ! tmux has-session -t "$session" &>/dev/null; then
          tmux new-session -d -s "$session"
      fi

      id=$(tmux display-message -p \#D)

      curr_path=$(tmux display-message -p '#{pane_current_path}')

      # create toggle term window for this specific pane
      if ! tmux has -t "$session":"$id" &>/dev/null; then
          tmux new-window -t "$session" -n "$id" -c "$curr_path" "${command}"
      fi


      if [ "$(tmux display-message -p '#{pane_current_path}')" != "$(tmux display-message -t "$session":"$id" -p '#{pane_current_path}')" ]; then
          tmux kill-window -t "$session":"$id"
          tmux new-window -t "$session" -n "$id" -c "$curr_path" "${command}"
       fi


      tmux display-popup -E -w 90% -h 90% -B "tmux a -t $session":"$id" &
    '';

  fsExScript = mkPopupSession "__file-ex" "${fileExplorer}; ${lib.getExe pkgs.zsh}";
  toggleTermScript = mkPopupSession "__toggle-term" "${lib.getExe pkgs.zsh}";

  copyScript = pkgs.writers.writeBash "tmux-copy.sh" ''
    if command -v wl-copy >/dev/null 2>&1 && [ -n "$WAYLAND_DISPLAY" ]; then
      wl-copy
    elif command -v xclip >/dev/null 2>&1 && [ -n "$DISPLAY" ]; then
      xclip -selection clipboard
    fi
  '';
in {
  home.file."scripts/toggle-term".source = toggleTermScript;
  home.file."scripts/file-ex".source = fsExScript;

  programs.tmux = {
    enable = true;

    baseIndex = 1;
    escapeTime = 10;

    historyLimit = 10000;

    terminal = "tmux-256color";
    extraConfig = ''
      set -sg terminal-overrides ",*:RGB"

      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      set -s focus-events on

      set -g set-titles on

      setw -g automatic-rename on
      set -g renumber-windows on

      setw -g monitor-activity on
      set -g visual-activity off

      set -g status-keys "vi"
      set -g mode-keys "vi"

      set -g pane-border-style fg=black
      set -g pane-active-border-style fg=grey

      # status bar

      set-option -g status-bg black
      set-option -g status-fg grey

      set -g window-status-format "#{?window_last_flag,#[fg=black]\uE0B0 #[fg=black]#I #W #[bg=black]#[fg=color236]\uE0B0, #I #W }"
      set -g window-status-current-format "#[fg=black,bg=color244]\uE0B0 #[fg=black,bg=color244]#I #W #[fg=color244,bg=black]\uE0B0"

      set -g window-status-activity-style "fg=white,bg=#{?window_last_flag,color236,black},underscore"
      set -g window-status-last-style fg=black,bg=color236,bold


      set -g status-right "#{?client_prefix,,}  #{?mouse,🖱️,} \uE0B3 #(whoami) \uE0B3 %I:%M %p \uE0B3 %d %b"


      # binds (most are borrowed from `https://github.com/gpakosz/.tmux`)

      bind Tab last-window
      bind C-c new-session

      bind - split-window -v
      bind _ split-window -h

      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

      bind > swap-pane -D
      bind < swap-pane -U

      bind . swap-window -t +1
      bind , swap-window -t -1

      bind -r H resize-pane -L 2
      bind -r J resize-pane -D 2
      bind -r K resize-pane -U 2
      bind -r L resize-pane -R 2

      bind m run "old=$(tmux show -gv mouse) && new=$( [ "$old" = "on" ] && echo "off" || echo "on" ); tmux set -g mouse $new;"


      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi C-v send -X rectangle-toggle
      bind -T copy-mode-vi y send -X copy-pipe-and-cancel "${copyScript}"
      bind -T copy-mode-vi Escape send -X cancel

      bind b set-option -g status
      bind g run-shell "${gitScript}"
      bind -n M-y run-shell "${fsExScript}"

      bind -n M-` run-shell "${toggleTermScript}"
      bind -n M-Escape copy-mode

      ${let
        bindsUnderCX =
          ["Any"]
          ++ builtins.attrNames config.programs.helix.settings.keys.normal.C-x;

        tmuxBinds =
          map
          (b: "bind-key -T CX ${b} set -g key-table root \\; set -g prefix C-b \\; send-keys ${b}")
          bindsUnderCX;
      in
        lib.foldl' (a: e: a + "\n" + e) "" tmuxBinds}

      bind-key -T root C-x set -g key-table CX \; set -g prefix C-a \; send-keys C-x
    '';
  };
}
