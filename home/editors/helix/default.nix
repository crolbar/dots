{
  inputs',
  pkgs,
  ...
}: {
  home.packages = [
    # :s/find/rep/g alternative
    (pkgs.writers.writeBashBin "s" ''sed "s/$1/g" '')
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
        emacsSave = {C-x.C-s = ":w";};
        vimMoves = {
          "$" = "goto_line_end";
          "0" = "goto_line_start";
          "_" = "goto_first_nonwhitespace";
          "%" = "match_brackets";
        };
      in {
        normal =
          {
            G = "goto_last_line";
            C-x.C-x = "decrement";

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
            };
          }
          // emacsSave
          // vimMoves;

        insert =
          {
            pageup = "no_op";
            pagedown = "no_op";
            home = "no_op";
            end = "no_op";

            C-h = "signature_help";
            C-c = "completion";
          }
          // emacsSave;
        select =
          {
            G = "extend_to_last_line";
          }
          // emacsSave
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
          [(lang "java") clang-format (indent 4 " ")]
          [(lang "nix") (fmt "alejandra" []) (indent 2 " ")]
        ];
    };
  };
}
