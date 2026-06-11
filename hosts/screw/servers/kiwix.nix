{pkgs, ...}: {
  services.kiwix-serve = {
    enable = true;
    library = {
      # wikipedia = "/data/wikipedia_en_all_maxi_2026-02.zim";
      arch = pkgs.fetchurl {
        url = "https://download.kiwix.org/zim/other/archlinux_en_all_maxi_2026-04.zim";
        hash = "sha256-AI0hzFdpmOF/IUMwnDkpGG47H4MfMhadx8ZFtiB6DhQ=";
      };

      nix = pkgs.fetchurl {
        url = "https://download.kiwix.org/zim/devdocs/devdocs_en_nix_2026-04.zim";
        hash = "sha256-kxs/KgulIlF+PmL1raouxmGQVLzELUPNcfH8ejkQIJs=";
      };
    };
  };
}
