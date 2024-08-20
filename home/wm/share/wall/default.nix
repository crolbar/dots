{
  home.file."wallpapers/nixwalls".source = ./wallpapers;
  home.file."scripts/wall.sh" = {
    source = ./wall.sh;
    executable = true;
  };
}
