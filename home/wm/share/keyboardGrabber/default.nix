{
  pkgs,
  lib,
  username,
  ...
} @ attr: let
  keebName = "AT Translated Set 2 keyboard";
  keyboardGrabber = import ./program.nix ({inherit keebName;} // attr);
  stray = lib.getExe' pkgs.stray "stray";
in
  pkgs.writers.writeBash "keyboardToggler" ''
    if pgrep -f "keyboardGrabber" > /dev/null; then
        sudo pkill -f "keyboardGrabber"
        kill $(cat /tmp/stray-keyboardToggler.pid)
        dunstify "keyboard ungrabbed"
    else
        sudo ${keyboardGrabber} &
        ${stray} --add-item "enable keeb" "sudo pkill -f keyboardGrabber && kill $(cat /tmp/stray-keyboardToggler.pid)" --name keyboardToggler --icon /home/${username}/keyboardToggler.png &
        dunstify "keyboard grabbed"
    fi
  ''
