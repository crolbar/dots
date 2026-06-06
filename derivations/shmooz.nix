{
  rustPlatform,
  pkg-config,
  wayland,
  wayland-protocols,
  libxkbcommon,
  fetchFromGitHub,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "shmooz";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "chmouel";
    repo = "shmooz";
    rev = "v0.3.0";
    sha256 = "sha256-U7nF2P1RRmDWk2C0DyXzGh+7TUk0kF3kVXGiKyFLCPA=";
  };

  cargoHash = "sha256-EKrrv89MclJKaX0pVnpmUzMIso3pXyJt4IBJN1muRz0=";

  nativeBuildInputs = [pkg-config];

  buildInputs = [
    wayland
    wayland-protocols
    libxkbcommon
  ];
}
