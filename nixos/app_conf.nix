{ pkgs, ... }:
{
    services.xserver = { 
        enable = true;
        windowManager.leftwm.enable = true;
        displayManager.startx.enable = true;
        desktopManager.xterm.enable = false;
        resolutions = [ { x = 3200; y = 2000; } ];
    };

    programs.git = {
        enable = true;
        package = pkgs.gitFull;
        config = {
            init = { defaultBranch = "master"; };
            url."https://github.com/".insteadOf = [ "gh:" ];
            credential.helper = "store";
        };
    };

    services.tumbler.enable = true;
    services.gvfs.enable = true;
    programs.thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
}
