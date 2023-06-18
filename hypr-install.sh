#!/bin/bash
# crolbar
case $1 in
"")
if command -v yay >/dev/null 2>&1; then
    pac=yay
elif command -v paru >/dev/null 2>&1; then
    pac=paru
else
    git clone https://aur.archlinux.org/yay.git /home/$user/yay && cd /home/$user/yay && makepkg -si --noconfirm
    pac=yay
fi
$pac -Sy --needed --noconfirm hyprland swaybg jq pamixer wofi dunst waybar pulseaudio alsa-utils zsh pavucontrol alacritty lsd ttf-hack ttf-font-awesome ttf-roboto dracula-icons-git polkit-gnome dracula-gtk-theme network-manager-applet thunar   
cp -a hypr /home/$user/.config/ 
cp -a alacritty /home/$user/.config/ 
cp -a zsh /home/$user/.config/ 
cp .zshrc /home/$user/
;;

arch-install)
sudo -u $user bash << EOF
git clone https://aur.archlinux.org/yay.git /home/$user/yay && cd /home/$user/yay && makepkg -si --noconfirm
yay -Sy --needed --noconfirm hyprland swaybg jq pamixer wofi dunst waybar pulseaudio alsa-utils zsh pavucontrol neofetch alacritty lsd ttf-hack ttf-font-awesome ttf-roboto dracula-icons-git polkit-gnome dracula-gtk-theme network-manager-applet thunar feh firefox mousepad ly physlock
sudo systemctl enable ly.service
cd /dots
cp -a hypr /home/$user/.config/ 
cp -a alacritty /home/$user/.config/ 
cp -a zsh /home/$user/.config/ 
cp .zshrc /home/$user/
echo 'GRUB_CMDLINE_LINUX_DEFAULT="nvidia_drm.modeset=1"' | sudo tee -a /etc/default/grub >> /dev/null
sudo grub-mkconfig -o /boot/grub/grub.cfg
EOF
;;

esac