# dev templates
# init with `nix flake init -t github:crolbar/dots#template_name`
let
  welcomeText = "Friendly reminder to `git init && git add .`";
in {
  flake.templates = {
    rust-parts = {
      description = "Rust dev env template + flake-parts";
      inherit welcomeText;
      path = ./rust-parts;
    };

    bb = {
      description = "bare bones flake";
      inherit welcomeText;
      path = ./bb;
    };

    bbe = {
      description = "bare bones flake + envrc & emacs ignores";
      inherit welcomeText;
      path = ./bbe;
    };

    c-make = {
      description = "full c + make minimal template";
      inherit welcomeText;
      path = ./c-make;
    };
  };
}
