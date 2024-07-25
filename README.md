- **Window Manager** • [Hyprland](https://github.com/hyprwm/Hyprland) / [Bspwm](https://github.com/baskerville/bspwm)
- **Shell** • [Zsh](https://www.zsh.org)
- **Terminal** • [Alacritty](https://github.com/alacritty/alacritty)
- **Panel** • [Waybar](https://github.com/Alexays/Waybar) / [Polybar](https://github.com/polybar/polybar)
- **Notify Daemon** • [Dunst](https://github.com/dunst-project/dunst)
- **Launcher** • [Wofi](https://hg.sr.ht/~scoopta/wofi) / [Rofi](https://github.com/davatorium/rofi)


## Hyprland
![hypr](https://github.com/crolbar/dots/assets/61518558/729384bf-afd9-4bcb-91c6-477c73cc56d2)

### Dependencies
```
yay -Sy --needed hyprland swaybg jq pamixer wofi dunst waybar zsh pavucontrol alacritty lsd ttf-hack ttf-font-awesome ttf-roboto dracula-icons-git polkit-gnome dracula-gtk-theme
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
yay -Sy --needed bspwm sxhkd picom dmenu dunst polybar zsh alacritty lsd ttf-hack ttf-font-awesome ttf-roboto dracula-icons-git polkit-gnome dracula-gtk-theme feh xorg-xrandr xorg-xinput xorg-server xorg-xinit
```
### Installation
```
git clone https://github.com/crolbar/dots ~/dots
cp -r ~/dots/bspwm ~/.config/bspwm
```
# Automation scripts 
- arch-install.sh - script to install arch (may not work on some systems) 
  - can't choose locales 
  - can't choose bootloader 
  - can't choose kernel
  - can't choose partition size 
  - auto uses networkmanager
- bspwm-install.sh - script ot isntall my bspwm config (with dependencies)
- hypr-install.sh - script ot isntall my hyprland config (with dependencies)

# GTK Themes
You can set themes with `lxappearance` or `nwg-look` for wayland.

### Icons
```
git clone https://github.com/m4thewz/dracula-icons ~/.local/share/icons/dracula-icons
```

# FIX ANNOYING VOLUME CONTROLS IN FIREFOX BROWSERS
so i have an problem where if i watch something like youtube and if i use the volume control in the youtube player it also changes the system volume of firefox (so the system volume and youtube player volume are synced)
- FIX: add `flat-volumes = yes` in `/etc/pulse/daemon.conf`

