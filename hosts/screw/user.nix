{pkgs, ...}: {
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users.root.hashedPassword = "$y$j9T$vRxv3vPo5oX1UuiSmJF5V/$MzK8chBLfjKPtHJ1OiMOBAXe.i/ykFvclahtkUWUh8B";
    users.screw = {
      isNormalUser = true;
      shell = pkgs.zsh;
      useDefaultShell = true;
      extraGroups = ["networkmanager" "wheel"];
      hashedPassword = "$y$j9T$vRxv3vPo5oX1UuiSmJF5V/$MzK8chBLfjKPtHJ1OiMOBAXe.i/ykFvclahtkUWUh8B";
    };
  };
}
