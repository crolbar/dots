{pkgs, ...}: {
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      gtk3
      pango
      atk
      cairo
      gdk-pixbuf
      glib

      openal
      pulseaudio
      love
      SDL2
      lua5_1
      libGL
      libGLU
      freetype
      openal
      libvorbis
      libogg
      libmodplug
      mpg123
      libpng
      libjpeg
      zlib
      fontconfig
      libX11
      libXrandr
      libXext
    ];
  };
}
