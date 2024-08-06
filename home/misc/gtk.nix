{pkgs, ...}: {
  gtk = {
    enable = true;
    cursorTheme = {
      name = "capitaine-cursors-white";
      package = pkgs.capitaine-cursors;
    };

    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };

    theme = {
      name = "Materia-dark-compact";
      package = pkgs.materia-theme;
    };
  };
}
