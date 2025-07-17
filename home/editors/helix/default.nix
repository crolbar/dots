{
  inputs',
  pkgs,
  ...
}: {
  home.packages = [
    # :s/find/rep/g alternative
    (pkgs.writers.writeBashBin "s" ''sed "s/$1/g" '')

    (pkgs.writers.writeBashBin "hx-compile" "$HOME/scripts/toggle-term && tmux send-keys -t __toggle-term:$(tmux display-message -p \\#D) up")
    (pkgs.writers.writeBashBin "hx-recompile" "$HOME/scripts/toggle-term && tmux send-keys -t __toggle-term:$(tmux display-message -p \\#D) up Enter")
  ];

  programs.helix = {
    enable = true;
    defaultEditor = false;
    package = inputs'.helix.packages.default;

    settings = {
      theme = "gruvbox";

      editor = {
        line-number = "relative";
        scrolloff = 15;
        default-yank-register = "+";
        middle-click-paste = false;
        continue-comments = false;
        auto-completion = true;
        auto-format = false;
        completion-timeout = 50;
        completion-replace = true;
        true-color = true;
        rulers = [80];
        bufferline = "never";
        color-modes = true;

        jump-label-alphabet = "abcdefghijklmnopqrstuvwxyz";

        cursorcolumn = false;
        cursorline = false;

        auto-pairs = false;

        file-picker = {
          hidden = false;
          git-ignore = false;
        };

        inline-diagnostics = {
          cursor-line = "hint";
        };
      };

      keys = let
        vimMoves = {
          "$" = "extend_to_line_end";
          "0" = "extend_to_line_start";
          "_" = "extend_to_first_nonwhitespace";
          "%" = "match_brackets";
          "}" = "goto_next_paragraph";
          "{" = "goto_prev_paragraph";
        };
      in {
        normal =
          {
            C-x = {
              C-s = ":w";
              C-x = "decrement";
              C-c = ":sh hx-compile";
              C-r = ":sh hx-recompile";
              C-b = "buffer_picker";
            };
            G = "goto_last_line";

            Z.Q = ":q!";
            C-t = "file_picker";
            C-r = "redo";
            s = "goto_word";

            A-H = "jump_view_left";
            A-J = "jump_view_down";
            A-K = "jump_view_up";
            A-L = "jump_view_right";

            A-b = "buffer_picker";

            A-f = ":format";

            K = "hover";
            space = {
              c.a = "code_action";
              a = "no_op";
              e = "no_op";
              E = "no_op";
              t = "file_explorer";
              T = "file_explorer_in_current_buffer_directory";
            };

            esc = "collapse_selection";
          }
          // vimMoves;

        insert = {
          C-x.C-s = ":w";
          pageup = "no_op";
          pagedown = "no_op";
          home = "no_op";
          end = "no_op";

          C-h = "signature_help";
          C-c = "completion";
        };
        select =
          {
            C-x.C-s = ":w";
            G = "extend_to_last_line";
          }
          // vimMoves;
      };
    };

    languages = let
      lang = name: {inherit name;};
      fmt = command: args: {formatter = {inherit command args;};};
      indent = tab-width: unit: {indent = {inherit tab-width unit;};};

      fold = list: builtins.foldl' (a: e: a // e) {} list;
      foldAll = langs: map (lang: fold lang) langs;
    in {
      language = let
        clang-format = fmt "clang-format" ["--style={\"BasedOnStyle\": \"Mozilla\", \"IndentWidth\": 4}"];
      in
        foldAll
        [
          [(lang "c") clang-format (indent 4 " ")]
          [(lang "cpp") clang-format (indent 4 " ")]
          [(lang "java") clang-format (indent 4 " ")]
          [(lang "nix") (fmt "alejandra" []) (indent 2 " ")]
        ];
    };
  };
}
