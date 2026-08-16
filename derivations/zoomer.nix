{
  stdenv,
  fetchFromGitHub,
  bash,
  callPackage,
  writeTextFile,
  ...
}: let
  src = fetchFromGitHub {
    owner = "cxinu";
    repo = "zoomer";
    rev = "0.0.1";
    sha256 = "sha256-oYDTvqUDw1UwzINQl32xQEUN8anZs3TbJ5qHvgC1k6k=";
  };
  bin = "${(callPackage "${src}/default.nix" {})}/bin/boomer";

  cfg = writeTextFile {
    name = "cfg";
    text = ''
      min_scale = 0.8
      scroll_speed = 2
      drag_friction = 10.0
      scale_friction = 8.0
    '';
  };
in
  stdenv.mkDerivation rec {
    pname = "zoomer";
    version = "0.0.1";

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin

      cat > $out/bin/${pname} <<'EOF'
      #!${bash}/bin/bash
      ${bin} -c ${cfg}
      EOF

      chmod +x $out/bin/${pname}
    '';
  }
