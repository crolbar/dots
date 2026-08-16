{lib, ...}: {
  xdg.portal = {
    enable = lib.mkForce false;
    extraPortals = lib.mkForce [];
  };
}
