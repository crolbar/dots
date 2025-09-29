{
  security = {
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
    pam.services = {
      swaylock = {};
      i3lock.enable = true;
    };
  };
}
