{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        dunst rofi leftwm eww i3lock picom 
#               ╔═╗╦  ╦
#               ║  ║  ║
#               ╚═╝╩═╝╩
        vim git zsh lsd fd btop htop
        neofetch neovim brightnessctl
        light pamixer tldr fzf zip 
        alacritty feh xclip unzip
        xorg.xev ncdu
        #bluez bluez-tools



#               ╔═╗╦ ╦╦
#               ║ ╦║ ║║
#               ╚═╝╚═╝╩
        firefox brave vscodium gnome.file-roller 
        mpv lxappearance xfce.thunar pavucontrol
        discord keepassxc spotify




#             ╔╦╗╔═╗╦  ╦
#              ║║║╣ ╚╗╔╝
#             ═╩╝╚═╝ ╚╝ 
        lua lua-language-server
        nodejs
        clang-tools gcc
        rustup
        python311 python311Packages.pip nodePackages.pyright

        nodePackages_latest.bash-language-server
        nodePackages_latest.vscode-langservers-extracted













#             ╔╦╗╦╔═╗╔═╗
#             ║║║║╚═╗║  
#             ╩ ╩╩╚═╝╚═╝
        capitaine-cursors
        pkg-config
        openssl
        glib



    ];
}

