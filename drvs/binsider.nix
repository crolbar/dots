{
  rustPlatform,
  fetchFromGitHub,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "binsider";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "orhun";
    repo = "binsider";
    rev = "v0.1.0";
    sha256 = "sha256-+QgbSpiDKPTVdSm0teEab1O6OJZKEDpC2ZIZ728e69Y=";
  };

  checkFlags = [
    "--skip=app::tests::test_extract_strings"
    "--skip=app::tests::test_init"
  ];

  cargoHash = "sha256-1A0mx5LeZvJTXpB/USCGSTlra9o4NgZQFeGccCj6h1Y=";
}
