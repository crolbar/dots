{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      hack-font #monospaced
      font-awesome #icon
      roboto # sans serif

      noto-fonts-cjk-sans # cjk

      nerd-fonts.symbols-only
    ];

    fontconfig.defaultFonts = {
      sansSerif = ["Roboto"];
      monospace = ["Hack"];
    };

    fontDir = {
      enable = true;
      decompressFonts = true;
    };
  };
}
