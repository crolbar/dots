{
  rustPlatform,
  fetchFromGitHub,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "rmpc";
  version = "git";

  src = fetchFromGitHub {
    owner = "mierak";
    repo = "rmpc";
    rev = "9247ba618f8e9148e9e674f919d34b051bccab37";
    sha256 = "sha256-Z+Iz29pnpqakQozkcHtahDiQXLbgZAkIn6LtMe6ropQ=";
  };

  cargoHash = "sha256-HGmmJrsDsfgjMw/db9b7JzA2Pp/jgWM/dKB7n13+AGE=";
}
