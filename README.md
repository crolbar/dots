- **Window Manager** • [Hyprland](https://github.com/hyprwm/Hyprland) / [Bspwm](https://github.com/baskerville/bspwm)
- **Shell** • [Zsh](https://www.zsh.org)
- **Terminal** • [Alacritty](https://github.com/alacritty/alacritty)
- **Panel** • [Waybar](https://aur.archlinux.org/packages/waybar-hyprland-git) / [Polybar](https://github.com/polybar/polybar)
- **Notify Daemon** • [Dunst](https://github.com/dunst-project/dunst)
- **Launcher** • [Rofi](https://github.com/davatorium/rofi) / [Wofi](https://hg.sr.ht/~scoopta/wofi)
- **File Manager** • [Thunar](https://github.com/xfce-mirror/thunar)


## Hyprland
![hypr](https://github.com/crolbar/dots/assets/61518558/729384bf-afd9-4bcb-91c6-477c73cc56d2)

### Dependencies
```
yay -Sy --noconfirm --needed hyprland swaybg jq pamixer wofi dunst waybar pulseaudio alsa-utils zsh pavucontrol alacritty lsd ttf-hack ttf-font-awesome ttf-roboto dracula-icons-git polkit-gnome dracula-gtk-theme network-manager-applet thunar 
```
### Installation
```
git clone https://github.com/crolbar/dots ~/dots
cp -r ~/dots/hypr ~/.config/hypr
```
## Bspwm
![bspwm](https://github.com/crolbar/dots/assets/61518558/cd9f535d-b9c7-4a08-bf01-49760feb487a)

### Dependencies
```
yay -Sy --noconfirm --needed bspwm sxhkd picom dmenu dunst polybar pulseaudio alsa-utils zsh pavucontrol neofetch alacritty lsd ttf-hack ttf-font-awesome ttf-roboto dracula-icons-git polkit-gnome dracula-gtk-theme network-manager-applet xfce4-power-manager thunar feh firefox xorg-xrandr xorg-xinput xorg-server xorg-xinit gedit ly physlock
```
### Installation
```
git clone https://github.com/crolbar/dots ~/dots
cp -r ~/dots/bspwm ~/.config/bspwm
```
# Automation scripts 
- arch-install.sh - script to install arch (may not work on some systems) \
  - can't choose locales \
  - can't choose bootloader \
  - can't choose kernel version \
  - can't choose partition size \
  - auto uses networkmanager
- bspwm-install.sh - script ot isntall my bspwm config (with dependencies)
- hypr-install.sh - script ot isntall my hyprland config (with dependencies)
