{stdenv, ...}:
stdenv.mkDerivation rec {
  pname = "main";
  version = "0.1";
  src = ./.;
  makeFlags = ["PREFIX=$(out) BINS=${pname}"];
}
