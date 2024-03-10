{pkgs, ...}:
{
    programs.zsh.enable = true; 
    users = {
        mutableUsers = false;
        defaultUserShell = pkgs.zsh;
        users.root = {
            hashedPassword = "$y$j9T$vRxv3vPo5oX1UuiSmJF5V/$MzK8chBLfjKPtHJ1OiMOBAXe.i/ykFvclahtkUWUh8B";
        }; 
        users.plier = {
            isNormalUser = true;
            useDefaultShell = true;
            extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
            hashedPassword = "$y$j9T$vRxv3vPo5oX1UuiSmJF5V/$MzK8chBLfjKPtHJ1OiMOBAXe.i/ykFvclahtkUWUh8B";
        }; 
    };
}
