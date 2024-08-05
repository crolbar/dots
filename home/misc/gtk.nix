{pkgs, ...}: {
  gtk = {
    enable = true;
    cursorTheme = {
      name = "capitaine-cursors-white";
      package = pkgs.capitaine-cursors;
    };

    iconTheme = {
      name = "dracula-icons";
      package = pkgs.gnome.adwaita-icon-theme;
    };

    theme = {
      name = "Materia-dark-compact";
      package = pkgs.materia-theme;
    };
  };
}
