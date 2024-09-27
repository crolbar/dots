let
  welcomeText = "Friendly reminder to `git init && git add .`";
in {
  flake.templates = {
    rust-parts = {
      description = "Rust dev env template + flake-parts";
      inherit welcomeText;
      path = ./rust-parts;
    };
  };
}
