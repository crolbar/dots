{
  stdenv,
  fetchurl,
  autoPatchelfHook,
  dpkg,
  ffmpeg_7-full,
  glib,
  gtk3,
  wrapGAppsHook,
  nss,
  xdg-utils,
  nspr,
  mesa,
  systemd,
  libglvnd,
  libGL,
  libGLU,
}:
stdenv.mkDerivation rec {
  pname = "zoho-mail";
  version = "1.6.3";

  src = fetchurl {
    url = "https://downloads.zohocdn.com/zmail-desktop/linux/zoho-mail-desktop-lite-installer-x64-v${version}.deb";
    hash = "sha256-pD3OgRLBTr5K2cDJ3p2LR8ASV4pUwRmo6ojXHH+KddY=";
  };

  nativeBuildInputs = [autoPatchelfHook wrapGAppsHook];

  dontWrapGApps = true;

  buildInputs = [
    dpkg
    ffmpeg_7-full
    glib
    gtk3
    nss
    xdg-utils
    nspr
    mesa
    libglvnd
    libGL
    libGLU
  ];

  runtimeDependencies = buildInputs ++ [systemd];

  unpackPhase = "dpkg-deb -x $src $out";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    sed -i 's|/opt/Zoho Mail - Desktop/zoho-mail-desktop|'"$out/bin/zoho-mail-desktop"'|' $out/usr/share/applications/zoho-mail-desktop.desktop

    cp -r $out/usr/share $out
    ln -s "$out/opt/Zoho Mail - Desktop/zoho-mail-desktop" $out/bin

    runHook postInstall
  '';
}
