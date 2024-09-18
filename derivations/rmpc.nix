{
  rustPlatform,
  fetchFromGitHub,
  ...
}:
rustPlatform.buildRustPackage {
  pname = "rmpc";
  version = "d7d5b5c276295b7ba356661d65f622e47b37902a";

  src = fetchFromGitHub {
    owner = "mierak";
    repo = "rmpc";
    rev = "d7d5b5c276295b7ba356661d65f622e47b37902a";
    sha256 = "sha256-PqdgF3XOGaio9tp5/dt6xWBSYT+x/WPkk4JQOBbbaKA=";
  };

  cargoHash = "sha256-RojhQ8539w+ifQBw/wBX7xw31Vx26NSPz1KYpvBBjT0=";
}
