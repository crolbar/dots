#!/usr/bin/env bash

git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
yay -S --needed bspwm sxhkd picom dmenu dunst polybar pulseaudio zsh pavucontrol neofetch alacritty lsd ttf-jetbrains-mono-nerd ttf-font-awesome ttf-roboto papirus-icon-theme xclip polkit-gnome materia-theme lxappearance network-manager-applet xfce4-power-manager nerd-fonts-complete-starship thunar feh firefox xorg-xrandr xorg-xinput xorg-server xorg-xinit gedit ly
systemctl enable ly.service
cp -R $HOME/bspwm/bspwm $HOME/.config/
cp -R $HOME/bspwm/alacritty $HOME/.config/
cp -R $HOME/bspwm/neofetch $HOME/.config/
cp -R $HOME/bspwm/zsh $HOME/.config/
cp -R $HOME/bspwm/.zshrc $HOME/




