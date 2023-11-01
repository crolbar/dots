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

        $pac -Sy --needed --noconfirm bspwm sxhkd picom dmenu dunst polybar pulseaudio alsa-utils zsh pavucontrol neofetch alacritty lsd ttf-hack ttf-font-awesome ttf-roboto polkit-gnome network-manager-applet xfce4-power-manager thunar feh xorg-xrandr xorg-xinput xorg-server xorg-xinit xclip
        cp -a bspwm ~/.config/ 
        cp -a alacritty ~/.config/ 
        cp -a zsh ~/.config/
        cp -a gtk-3.0 ~/.config/  
        cp .zshrc ~
        ;;

    arch-install)
        sudo -u $user bash << EOF
            git clone https://aur.archlinux.org/yay-bin.git /home/$user/yay && cd /home/$user/yay && makepkg -si --noconfirm
            yay -Sy --needed --noconfirm bspwm sxhkd picom dmenu dunst polybar pulseaudio alsa-utils zsh pavucontrol neofetch alacritty lsd ttf-hack ttf-font-awesome ttf-roboto polkit-gnome network-manager-applet xfce4-power-manager thunar feh firefox xorg-xrandr xorg-xinput xorg-server xorg-xinit mousepad ly physlock xclip
            sudo systemctl enable ly.service
            cd /dots
            cp -a bspwm /home/$user/.config/ 
            cp -a alacritty /home/$user/.config/ 
            cp -a zsh /home/$user/.config/
            cp -a gtk-3.0 /home/$user/.config/  
            cp .zshrc /home/$user/
        EOF;;

esac
