{ pkgs, ... }:
{
    services.xserver = { 
        enable = true;
        windowManager.leftwm.enable = true;
        displayManager.startx.enable = true;
        desktopManager.xterm.enable = false;
        resolutions = [ { x = 3200; y = 2000; } ];
    };
    services.sshd.enable = true;

    programs.git = {
        enable = true;
        package = pkgs.gitFull;
        config = {
            init = { defaultBranch = "master"; };
            url."https://github.com/".insteadOf = [ "gh:" ];
            credential.helper = "store";
        };
    };
    
    services = {
        tumbler.enable = true;
        gvfs.enable = true;
        tlp.enable = true;
        syncthing = {
            user = "plier";
            enable = true;
            systemService = false;
        };
    };

    virtualisation.libvirtd.enable = true;
    virtualisation.docker.enable = true;
    programs.virt-manager.enable = true;


    programs.thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
}
