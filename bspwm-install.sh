#!/bin/bash
# crolbar
sudo -u $user bash << EOF
git clone https://aur.archlinux.org/yay.git /home/$user/ && cd /home/$user/yay && makepkg -si --noconfirm
yay -Sy --needed --noconfirm bspwm sxhkd picom dmenu dunst polybar pulseaudio alsa-utils zsh pavucontrol neofetch alacritty lsd ttf-hack ttf-font-awesome ttf-roboto dracula-icons-git polkit-gnome dracula-gtk-theme network-manager-applet xfce4-power-manager thunar feh firefox xorg-xrandr xorg-xinput xorg-server xorg-xinit gedit ly mesa physlock
sudo systemctl enable ly.service
cd /dots
mkdir /home/$user/.config 
cp -a bspwm /home/$user/.config/ 
cp -a alacritty /home/$user/.config/ 
cp -a neofetch /home/$user/.config/ 
cp -a zsh /home/$user/.config/
cp -a gtk-3.0 /home/$user/.config/  
cp .zshrc /home/$user/
EOF