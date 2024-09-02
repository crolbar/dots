<h1 align="center"> NixOS - Home Manager - Flakes config </h1>

<div align="center">
    This <a href="https://nixos.wiki/wiki/Flakes ">nix flake</a> contains NixOS configurations for all of my <a href="#Hosts" />systems</a> and with the help of <a href="https://github.com/nix-community/home-manager">Home Manager</a> for all of the <a href="#Software" >software</a> that I'm using. 
</div><br/><br/>

![](.github/assets/Screenshot-2024-08-28_11:20:29.png)


# Hosts
- **308**: Desktop PC with a Ryzen 5 3600 and a 1060 3bg (old but does the job for me). Running Hyprland.
- **plier**: ASUS Vivobook with an Intel i5-1235U (got it mainly for the OLED display). Running river.
- **screw**: Raspbery Pi 4B as an home server (until I make a proper one). Running [blocky](https://github.com/0xERR0R/blocky) & a [forgejo](https://forgejo.org/) instance.
- **vm**: Basic VM config for testing.

Don't even ask me about the names.. (I have an weird naming convention I know)

# Software
The software I use across my systems is:

### Wayland compositors
- [Hyprland](https://github.com/hyprwm/Hyprland) - (config: [home/wm/hypr](home/wm/hypr))
- [river](https://isaacfreund.com/software/river/) - (config: [home/wm/river](home/wm/river))

### Window managers
- [LeftWM](https://github.com/leftwm/leftwm) - for when something doesn't work on river (config: [home/wm/left](home/wm/left))
- [bspwm](https://github.com/baskerville/bspwm) - for when something doesn't work on Hyprland (config: [home/wm/bsp](home/wm/bsp))

### Terminal
| Name | Description | Configuration |
| :--- | :---------- | :------------ |
| Zsh  | shell | [home/cil/zsh.nix](home/cli/zsh.nix) & [hosts/shared/cil/zsh.nix](hosts/shared/cli/zsh.nix) |
| [yazi](https://github.com/sxyazi/yazi) | file manager | [hosts/shared/cli/yazi](hosts/shared/cli/yazi.nix)
| [Starship](https://github.com/starship/starship) | easy and useful prompt | [home/cli/starship](home/cli/starship.nix) |
| [tmux](https://github.com/tmux/tmux) | terminal multiplexer (maybe switching to [zellij](https://github.com/zellij-org/zellij) soon) | [home/cli/tmux](home/cli/tmux.nix) |
| [Gitui](https://github.com/extrawurst/gitui) | git frontend | [home/cli/gitui](home/cli/gitui.nix) |
| [neovim](https://github.com/neovim/neovim) | text editor | [home/cli/neovim](home/cli/neovim) |


### GUI
| Name | Description | Configuration |
| :--- | :---------- | :------------ |
| [Alacritty](https://github.com/alacritty/alacritty) | terminal emulator | [home/cli/alacritty](home/gui/term_emulators/alacritty.nix) |
| [Schizofox](https://github.com/schizofox/schizofox) | easy way for a daly-drivable hardened firefox | [home/cli/schizofox](home/gui/schizofox.nix) |
| [Zathura](https://github.com/pwmt/zathura) | simple document viewer with vim bindings | [home/gui/zathura](home/gui/zathura.nix) |
| [eww](https://github.com/elkowar/eww) | widget system used mainly for bars | [home/gui/eww](home/gui/eww) & [home/wm/hypr/eww](home/wm/hypr/eww) & [home/wm/left/leftwm/right/eww](home/wm/left/leftwm/right/eww)|
| [rofi](https://github.com/davatorium/rofi) | launcher for x11 | [home/wm/share/rofi](home/wm/share/rofi) |
| [anyrun](https://github.com/anyrun-org/anyrun) | launcher for wayland | [home/wm/share/wayland/anyrun.nix](home/wm/share/wayland/anyrun.nix) |
| [swww](https://github.com/LGFae/swww) | wallpaper solution for wayland | [home/wm/share/wall](home/wm/share/wall)
| [feh](https://github.com/derf/feh) | wallpaper solution for x11 | [home/wm/share/wall](home/wm/share/wall)


# Credits
**BIG** help in the making of this flake were [NotAShelf's]() [nyx](https://github.com/NotAShelf/nyx) and [fufexan's](https://github.com/fufexan) [dotfiles](https://github.com/fufexan/dotfiles).
