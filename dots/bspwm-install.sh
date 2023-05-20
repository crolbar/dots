#!/bin/bash
# crolbar
echo "
=========================================
do you want to use my bspwm config yes/no
========================================="
read WM
if [[ $WM == y ]] || [[ $WM == yes ]];
then
git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -Sy --needed --noconfirm bspwm sxhkd picom dmenu dunst polybar pulseaudio zsh pavucontrol neofetch alacritty lsd ttf-hack ttf-font-awesome ttf-roboto papirus-icon-theme xclip polkit-gnome materia-theme network-manager-applet xfce4-power-manager thunar feh firefox xorg-xrandr xorg-xinput xorg-server xorg-xinit gedit ly mesa physlock
sudo systemctl enable ly.service
git clone https://github.com/crolbar/dots
    cd dots
    mkdir $HOME/.config 
    mkdir $HOME/.config/bspwm 
    cp -a bspwm $HOME/.config/ 
    cp -a alacritty $HOME/.config/ 
    cp -a neofetch $HOME/.config/ 
    cp -a zsh $HOME/.config/ 
    cp .zshrc $HOME/
elif [[ $WM == no ]];
then
    exit
else 
    exit
fi 