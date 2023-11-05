{ pkgs, ... }:

let
     rust = pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.default.override {
      extensions = [ "rust-src" ];
    });

in
{
    environment.systemPackages = with pkgs; [

        dunst rofi leftwm eww i3lock picom
#               ╔═╗╦  ╦
#               ║  ║  ║
#               ╚═╝╩═╝╩
        vim git zsh lsd fd btop htop
        neofetch neovim brightnessctl
        light pamixer tldr fzf zip 
        alacritty xclip unzip tree
        xorg.xev ncdu tmux skim
        silver-searcher



        #bluez bluez-tools
#               ╔═╗╦ ╦╦
#               ║ ╦║ ║║
#               ╚═╝╚═╝╩
        firefox brave vscodium gnome.file-roller 
        mpv lxappearance xfce.thunar pavucontrol
        discord keepassxc spotify gimp feh mate.eom



#             ╔╦╗╔═╗╦  ╦
#              ║║║╣ ╚╗╔╝
#             ═╩╝╚═╝ ╚╝ 
        glib cairo gdk-pixbuf gtk3-x11
        gtk4 pango glibc pkg-config openssl
        

        lua lua-language-server
        nodejs
        clang-tools gcc clang

        rust rust-analyzer

        nixd

        python311 python311Packages.pip nodePackages.pyright

        nodePackages_latest.bash-language-server
        nodePackages_latest.vscode-langservers-extracted













#             ╔╦╗╦╔═╗╔═╗
#             ║║║║╚═╗║  
#             ╩ ╩╩╚═╝╚═╝
        capitaine-cursors
        libsecret
        git-credential-manager
    ];
}
