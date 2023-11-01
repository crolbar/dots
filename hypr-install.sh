#!/bin/bash
# crolbar
case $1 in
    "")
        if command -v yay >/dev/null 2>&1; then
            pac=yay
        elif command -v paru >/dev/null 2>&1; then
            pac=paru
        else
            git clone https://aur.archlinux.org/yay-bin.git ~/yay && cd ~/yay && makepkg -si --noconfirm
            pac=yay
        fi

        $pac -Sy --needed --noconfirm hyprland swaybg jq pamixer wofi dunst waybar pulseaudio alsa-utils zsh pavucontrol alacritty lsd ttf-hack ttf-font-awesome ttf-roboto polkit-gnome network-manager-applet thunar wl-clipboard swaylock nwg-look-bin
        cp -a hypr ~/.config/ 
        cp -a alacritty ~/.config/ 
        cp -a zsh ~/.config/ 
        cp .zshrc ~
        ;;

    arch-install)
        sudo -u $user bash << EOF
            git clone https://aur.archlinux.org/yay-bin.git /home/$user/yay && cd /home/$user/yay && makepkg -si --noconfirm
            yay -Sy --needed --noconfirm hyprland swaybg jq pamixer wofi dunst waybar pulseaudio alsa-utils zsh pavucontrol neofetch alacritty lsd ttf-hack ttf-font-awesome ttf-roboto polkit-gnome network-manager-applet thunar feh brave-bin mousepad ly wl-clipboard swaylock nwg-look-bin
            sudo systemctl enable ly.service
            cd /dots
            cp -a hypr /home/$user/.config/ 
            cp -a alacritty /home/$user/.config/ 
            cp -a zsh /home/$user/.config/ 
            cp .zshrc /home/$user/
        EOF
        ;;

esac
