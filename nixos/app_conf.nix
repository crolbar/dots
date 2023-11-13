{ pkgs, ... }:
{
    services.xserver = { 
        enable = true;
        windowManager.leftwm.enable = true;
        displayManager.startx.enable = true;
        desktopManager.xterm.enable = false;
        resolutions = [ { x = 3200; y = 2000; } ];

        xautolock = {
            enable = true;
            enableNotifier = true;
            locker = "${pkgs.i3lock}/bin/i3lock -c 000000";
            killer = "/run/current-system/systemd/bin/systemctl suspend";
            notifier = "${pkgs.libnotify}/bin/dunstify 'Locking in 10 seconds'";
        };
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
