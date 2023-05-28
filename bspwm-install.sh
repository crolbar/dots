#!/bin/bash
# crolbar
cd /dots
sudo -u $user bash << EOF
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm
yay -Sy --needed --noconfirm bspwm sxhkd picom dmenu dunst polybar pulseaudio alsa-utils zsh pavucontrol neofetch alacritty lsd ttf-hack ttf-font-awesome ttf-roboto dracula-icons-git polkit-gnome dracula-gtk-theme network-manager-applet xfce4-power-manager thunar feh firefox xorg-xrandr xorg-xinput xorg-server xorg-xinit gedit ly mesa physlock
sudo systemctl enable ly.service
git clone https://github.com/crolbar/dots
cd dots
mkdir $HOME/.config 
mkdir $HOME/.config/bspwm 
cp -a bspwm $HOME/.config/ 
cp -a alacritty $HOME/.config/ 
cp -a neofetch $HOME/.config/ 
cp -a zsh $HOME/.config/
cp -a gtk-3.0 $HOME/.config/  
cp .zshrc $HOME/
EOF