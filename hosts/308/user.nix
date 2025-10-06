{
  pkgs,
  username,
  ...
}: {
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users.${username} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      useDefaultShell = true;
      extraGroups = ["networkmanager" "wheel" "libvirtd" "docker" "dialout" "audio" "kvm"];
      hashedPassword = "$y$j9T$vRxv3vPo5oX1UuiSmJF5V/$MzK8chBLfjKPtHJ1OiMOBAXe.i/ykFvclahtkUWUh8B";
    };
  };
}
