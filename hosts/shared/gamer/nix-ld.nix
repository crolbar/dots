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

      nss
      nspr
      gnome2.GConf
      libX11
      libXi
      libXcursor
      libXext
      libXfixes
      libXrender
      libXcomposite
      libXdamage
      libXtst
      libXrandr
      alsa-lib
      expat
      dbus
      gtk2
      libnotify

      # TS3
      glib
      libGL
      nss
      nspr
      libevent
      libx11
      libxcomposite
      libxdamage
      libxext
      libxfixes
      libxrender
      libxrandr
      libxtst
      freetype
      expat
      fontconfig
      libxcb
      libxkbcommon
      dbus
      pciutils
      alsa-lib
      zlib
      libxml2_13
      libxslt
      lcms2
      stdenv.cc.cc.lib
      # Qt xcb plugin
      libxcb-util
      libxcb-image
      libxcb-keysyms
      libxcb-render-util
      libxcb-wm # icccm + ewmh
      libxkbfile
      libxi
      libxcursor
      libxscrnsaver
      libsm
      libice
      libxshmfence
      # Qt wayland / EGL plugins
      wayland
      libglvnd
      libdrm
      libgbm
      mesa

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
