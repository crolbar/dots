{
  stdenv,
  libsForQt5,
  openal,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "KeyboardVisualizer";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "CalcProgrammer1";
    repo = "KeyboardVisualizer";
    rev = "b50cc508f01fddfc2de9909c2611e75816ee444a";
    sha256 = "sha256-RJ7DN2Na35PaWa5hp7G37eZAIPsSi7otEmyU7vikQMs=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [libsForQt5.qmake libsForQt5.qt5.wrapQtAppsHook];
  buildInputs = [openal];
}
