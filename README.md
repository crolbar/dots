<h1 align="center"> Nix Dotfiles </h1>
<div align=center>

![created_at](https://img.shields.io/github/created-at/crolbar/dots?style=for-the-badge&color=blue)
![size](https://img.shields.io/github/languages/code-size/crolbar/dots?style=for-the-badge)
![loc](https://img.shields.io/badge/lines%20of%20code-15786-blue?style=for-the-badge)

</div>
<div align="center">
  Nix <a href="https://nixos.wiki/wiki/Flakes ">flake</a> configuration of all the personal computer systems I use, with <a href="https://github.com/nix-community/home-manager">Home Manager</a> managing my <b>$HOME</b>.
</div><br/><br/>

https://github.com/user-attachments/assets/91080132-1318-4580-bd34-b0051e98a246

> What is nix? Nix mainly refers to the package manager, which uses the nix
> language, used to build the opearating system NixOS.

# Hardware

- [308](hosts/308): Desktop PC running an AMD Ryzen 5 3600 CPU with AMD Radeon
  9060XT GPU
- [plier](hosts/plier): ASUS laptop running an Intel i5-1235U with a 16" 3K OLED
- [screw](hosts/screw): Raspbery Pi 4B home server

# Software

The software I use across my systems

### Display Servers

| Name                                             | Architecture | Configuration                  |
| :----------------------------------------------- | :----------- | :----------------------------- |
| [Hyprland](https://github.com/hyprwm/Hyprland)   | Wayland      | [home/wm/hypr](home/wm/hypr)   |
| [niri](https://github.com/niri-wm/niri)          | Wayland      | [home/wm/niri](home/wm/niri)   |
| [red](https://github.com/crolbar/red)            | Wayland      | [home/wm/red](home/wm/red)     |
| [i3](https://github.com/i3/i3)                   | X11          | [home/wm/i3](home/wm/i3)       |
| [river](https://isaacfreund.com/software/river/) | Wayland      | [home/wm/river](home/wm/river) |
| [bsp](https://github.com/baskerville/bspwm)      | X11          | [home/wm/bsp](home/wm/bsp)     |
| [sway](https://github.com/swaywm/sway)           | Wayland      | [home/wm/sway](home/wm/sway)   |
| [leftwm](https://github.com/leftwm/leftwm)       | X11          | [home/wm/left](home/wm/left)   |

in someway sorted by usetime from top to bottom

> Why so many? I like trying out different software, to get new ideas for
> improving my workflow.

### Terminal

| Name                                                | Description          | Configuration                                                                       |
| :-------------------------------------------------- | :------------------- | :---------------------------------------------------------------------------------- |
| Zsh                                                 | Shell                | [home/cil/zsh](home/cli/zsh.nix) & [hosts/shared/cil/zsh](hosts/shared/cli/zsh.nix) |
| [Helix](https://github.com/helix-editor/helix)      | IDE                  | [home/editors/helix](home/editors/helix)                                            |
| [lazygit](https://github.com/jesseduffield/lazygit) | Git Frontend         | [home/cli/lazygit](home/cli/lazygit.nix)                                            |
| [yazi](https://github.com/sxyazi/yazi)              | File Manager         | [hosts/shared/cli/yazi](hosts/shared/cli/yazi.nix)                                  |
| [tmux](https://github.com/tmux/tmux)                | Terminal Multiplexer | [home/cli/tmux](home/cli/tmux.nix)                                                  |
| [Starship](https://github.com/starship/starship)    | Prompt               | [home/cli/starship](home/cli/starship.nix)                                          |
| [Gitui](https://github.com/extrawurst/gitui)        | Git Frontend         | [home/cli/gitui](home/cli/gitui.nix)                                                |
| [neovim](https://github.com/neovim/neovim)          | Text Editor          | [home/editors/neovim](home/editors/neovim)                                          |
| [Emacs](https://www.gnu.org/software/emacs/)        | Operating System     | [home/editors/emacs](home/editors/emacs)                                            |

### Graphical

| Name                                            | Description                    | Configuration                                                    |
| :---------------------------------------------- | :----------------------------- | :--------------------------------------------------------------- |
| [foot](https://codeberg.org/dnkl/foot)          | Terminal Emulator              | [home/gui/term_emulators/foot](home/gui/term_emulators/foot.nix) |
| [zathura](https://github.com/pwmt/zathura)      | PDF Viewer                     | [home/gui/zathura](home/gui/zathura.nix)                         |
| [mpv](https://mpv.io)                           | Media Player                   | [home/gui/mpv](home/gui/mpv.nix)                                 |
| [quickshell](https://quickshell.org)            | Desktop shell                  | [home/wm/share/quickshell](home/wm/share/quickshell)             |
| [fuzzel](https://codeberg.org/dnkl/fuzzel)      | Application launcher (Wayland) | [home/wm/share/wayland/fuzzel](home/wm/share/wayland/fuzzel.nix) |
| [rofi](https://github.com/davatorium/rofi)      | Application launcher (X11)     | [home/wm/share/rofi](home/wm/share/rofi)                         |
| [awww](https://codeberg.org/LGFae/awww)         | Wallpaper (Wayland)            | [home/wm/share/wall](home/wm/share/wall)                         |
| [feh](https://github.com/derf/feh)              | Wallpaper (x11)                | [home/wm/share/wall](home/wm/share/wall)                         |
| [dunst](https://github.com/dunst-project/dunst) | Notification Daemon            | [home/wm/share/dunst](home/wm/share/dunst.nix)                   |
| [Vivaldi](https://vivaldi.com/download/)        | Browser                        | [home/gui/browsers/vivaldi](home/gui/browsers/vivaldi.nix)       |

## Binds

Becasue I use a number of display servers - and I want to have the same
keybindings in all of them - I had to make a way to define the binds once and
use them across all.

To solve this issue I use:

- [home/wm/share/binds/default.nix](home/wm/share/binds/default.nix) defining a
  function that takes settings and generates me list of binds with a simple
  format

```
[[mods] key cmd]
```

- [lib/bindsTranslator.nix](lib/bindsTranslator.nix) defining multiple functions
  used to translate this format into what ever the format of the display server
  is.

- [modules/hm/cbinds.nix](modules/hm/cbinds.nix) home manager module that
  exposes this functionality in a nice way. (example:
  [home/wm/niri/binds.nix](home/wm/niri/binds.nix))

<br/>

This way, when I'm configuring a new display server, I only have to define the
differences, like action or key names.

<details>
    <summary><h1>Repository Tree</h1></summary>

```nix
.
├── checks
│   └── default.nix
├── derivations
│   ├── 0001-is_fullscreen-ipc-window-state.patch
│   ├── binsider.nix
│   ├── KeyboardVisualizer.nix
│   ├── niri.nix
│   ├── openrgb-9.nix
│   ├── proton-em.nix
│   ├── proton-ge-bin.nix
│   ├── rmpc.nix
│   ├── shmooz.nix
│   ├── zohoMail.nix
│   └── zoomer.nix
├── home
│   ├── cli
│   │   ├── zzz
│   │   │   ├── dapu.nix
│   │   │   └── default.nix
│   │   ├── age.nix
│   │   ├── btop.nix
│   │   ├── default.nix
│   │   ├── git.nix
│   │   ├── gitui.nix
│   │   ├── lazygit.nix
│   │   ├── leetcode_cli.nix
│   │   ├── starship.nix
│   │   ├── tmux.nix
│   │   ├── zellij.nix
│   │   └── zsh.nix
│   ├── dev
│   │   ├── c.nix
│   │   ├── default.nix
│   │   ├── go.nix
│   │   ├── java.nix
│   │   ├── js.nix
│   │   ├── lua.nix
│   │   ├── nix.nix
│   │   ├── ocaml.nix
│   │   ├── php.nix
│   │   ├── python.nix
│   │   ├── rust.nix
│   │   └── zig.nix
│   ├── editors
│   │   ├── emacs
│   │   │   ├── crol.el
│   │   │   ├── default.nix
│   │   │   ├── epkgs.nix
│   │   │   └── init.el
│   │   ├── helix
│   │   │   └── default.nix
│   │   ├── neovim
│   │   │   ├── nvim
│   │   │   │   ├── lua
│   │   │   │   │   ├── lib
│   │   │   │   │   │   └── nivm_tree_git_open.lua
│   │   │   │   │   ├── plugins
│   │   │   │   │   │   ├── brrr.lua
│   │   │   │   │   │   ├── cmp.lua
│   │   │   │   │   │   ├── colorizer.lua
│   │   │   │   │   │   ├── comment.lua
│   │   │   │   │   │   ├── conform.lua
│   │   │   │   │   │   ├── discord.lua
│   │   │   │   │   │   ├── dressing.lua
│   │   │   │   │   │   ├── feline.lua
│   │   │   │   │   │   ├── gitsigns.lua
│   │   │   │   │   │   ├── harpoon.lua
│   │   │   │   │   │   ├── ibl.lua
│   │   │   │   │   │   ├── init.lua
│   │   │   │   │   │   ├── lsp.lua
│   │   │   │   │   │   ├── markdown_preview.lua
│   │   │   │   │   │   ├── noice.lua
│   │   │   │   │   │   ├── nvimtree.lua
│   │   │   │   │   │   ├── oil.lua
│   │   │   │   │   │   ├── telescope.lua
│   │   │   │   │   │   ├── term.lua
│   │   │   │   │   │   ├── theme.lua
│   │   │   │   │   │   ├── treesitter.lua
│   │   │   │   │   │   └── zen.lua
│   │   │   │   │   ├── binds.lua
│   │   │   │   │   ├── init_lazy.lua
│   │   │   │   │   └── set.lua
│   │   │   │   ├── init.lua
│   │   │   │   ├── lazy-lock.json
│   │   │   │   └── LICENSE
│   │   │   └── default.nix
│   │   └── default.nix
│   ├── gui
│   │   ├── browsers
│   │   │   ├── default.nix
│   │   │   ├── extensions.nix
│   │   │   ├── schizofox.nix
│   │   │   ├── vivaldi.nix
│   │   │   └── zen-browser.nix
│   │   ├── term_emulators
│   │   │   ├── ghostty_shaders
│   │   │   │   ├── crt.glsl
│   │   │   │   └── snow.glsl
│   │   │   ├── alacritty.nix
│   │   │   ├── default.nix
│   │   │   ├── foot.nix
│   │   │   ├── ghostty.nix
│   │   │   └── wezterm.nix
│   │   ├── default.nix
│   │   ├── KeyboardVisualizer.nix
│   │   ├── mpv.nix
│   │   ├── nextcloud.nix
│   │   ├── obs.nix
│   │   ├── spotify.nix
│   │   ├── zathura.nix
│   │   └── zoho.nix
│   ├── misc
│   │   ├── rmpc
│   │   │   ├── config.ron
│   │   │   ├── default.nix
│   │   │   └── theme.ron
│   │   ├── xdg
│   │   │   ├── associations.nix
│   │   │   └── default.nix
│   │   ├── agenix.nix
│   │   ├── default.nix
│   │   ├── gtk.nix
│   │   ├── mangohud.nix
│   │   └── mpd.nix
│   ├── non_nixos
│   │   ├── default.nix
│   │   ├── nix.nix
│   │   └── yazi.nix
│   ├── profiles
│   │   ├── crolbar
│   │   │   ├── wvm
│   │   │   │   ├── default.nix
│   │   │   │   ├── win10devices.nix
│   │   │   │   └── wvm.nix
│   │   │   ├── default.nix
│   │   │   ├── packages.nix
│   │   │   ├── screw-deploy.nix
│   │   │   └── shell_aliases.nix
│   │   ├── crolchy
│   │   │   ├── default.nix
│   │   │   └── shell_aliases.nix
│   │   ├── kubo
│   │   │   ├── default.nix
│   │   │   └── shell_aliases.nix
│   │   ├── plier
│   │   │   ├── default.nix
│   │   │   ├── packages.nix
│   │   │   └── shell_aliases.nix
│   │   ├── pvm
│   │   │   ├── default.nix
│   │   │   └── shell_aliases.nix
│   │   ├── screw
│   │   │   ├── default.nix
│   │   │   └── shell_aliases.nix
│   │   ├── win
│   │   │   ├── default.nix
│   │   │   └── shell_aliases.nix
│   │   └── home.nix
│   ├── wm
│   │   ├── bsp
│   │   │   ├── eww
│   │   │   │   ├── scripts
│   │   │   │   │   ├── bsp.nix
│   │   │   │   │   ├── default.nix
│   │   │   │   │   └── pulse.nix
│   │   │   │   ├── default.nix
│   │   │   │   ├── eww.scss
│   │   │   │   └── eww.yuck
│   │   │   ├── default.nix
│   │   │   ├── polybar.nix
│   │   │   └── sxhkd.nix
│   │   ├── hypr
│   │   │   ├── eww
│   │   │   │   ├── scripts
│   │   │   │   │   ├── default.nix
│   │   │   │   │   ├── hyprland.c
│   │   │   │   │   ├── hyprland.nix
│   │   │   │   │   ├── workspace_scroll.c
│   │   │   │   │   └── workspace_scroll.nix
│   │   │   │   ├── default.nix
│   │   │   │   ├── eww.scss
│   │   │   │   └── eww.yuck
│   │   │   ├── scripts
│   │   │   │   ├── default.nix
│   │   │   │   ├── dispatch.c
│   │   │   │   └── dispatch.nix
│   │   │   ├── binds.nix
│   │   │   ├── default.nix
│   │   │   └── settings.nix
│   │   ├── i3
│   │   │   ├── binds.nix
│   │   │   ├── default.nix
│   │   │   └── kb.nix
│   │   ├── left
│   │   │   ├── eww
│   │   │   │   ├── btm_tray
│   │   │   │   │   ├── btm_tray.scss
│   │   │   │   │   └── btm_tray.yuck
│   │   │   │   ├── tags
│   │   │   │   │   ├── tags.scss
│   │   │   │   │   └── tags.yuck
│   │   │   │   ├── eww.scss
│   │   │   │   └── eww.yuck
│   │   │   ├── binds.nix
│   │   │   ├── default.nix
│   │   │   ├── kb.nix
│   │   │   ├── settings.nix
│   │   │   └── workspace_scroll.nix
│   │   ├── niri
│   │   │   ├── binds.nix
│   │   │   ├── config.kdl
│   │   │   └── default.nix
│   │   ├── red
│   │   │   ├── binds.nix
│   │   │   └── default.nix
│   │   ├── river
│   │   │   ├── eww
│   │   │   │   ├── btm_tray
│   │   │   │   │   ├── btm_tray.scss
│   │   │   │   │   └── btm_tray.yuck
│   │   │   │   ├── scripts
│   │   │   │   │   ├── default.nix
│   │   │   │   │   ├── ristate.c
│   │   │   │   │   └── ristate.nix
│   │   │   │   ├── tags
│   │   │   │   │   ├── tags.scss
│   │   │   │   │   └── tags.yuck
│   │   │   │   ├── default.nix
│   │   │   │   ├── eww.scss
│   │   │   │   └── eww.yuck
│   │   │   ├── binds.nix
│   │   │   ├── default.nix
│   │   │   ├── kanshi.nix
│   │   │   ├── settings.nix
│   │   │   └── way_displays.nix
│   │   ├── share
│   │   │   ├── binds
│   │   │   │   ├── default.nix
│   │   │   │   ├── helpers.nix
│   │   │   │   └── river.nix
│   │   │   ├── keyboardGrabber
│   │   │   │   ├── default.nix
│   │   │   │   └── program.nix
│   │   │   ├── quickshell
│   │   │   │   ├── shell
│   │   │   │   │   ├── config
│   │   │   │   │   │   └── Config.qml
│   │   │   │   │   ├── modules
│   │   │   │   │   │   ├── bar
│   │   │   │   │   │   │   ├── audio
│   │   │   │   │   │   │   │   ├── audioCtl
│   │   │   │   │   │   │   │   │   ├── AudioCtlWindow.qml
│   │   │   │   │   │   │   │   │   ├── Button.qml
│   │   │   │   │   │   │   │   │   ├── Node.qml
│   │   │   │   │   │   │   │   │   └── Slider.qml
│   │   │   │   │   │   │   │   ├── AudioDevice.qml
│   │   │   │   │   │   │   │   ├── Audio.qml
│   │   │   │   │   │   │   │   ├── IconMouseArea.qml
│   │   │   │   │   │   │   │   ├── Sink.qml
│   │   │   │   │   │   │   │   └── Source.qml
│   │   │   │   │   │   │   ├── trayMenu
│   │   │   │   │   │   │   │   ├── TrayMenu.qml
│   │   │   │   │   │   │   │   └── TrayMenuWindow.qml
│   │   │   │   │   │   │   ├── BarLoader.qml
│   │   │   │   │   │   │   ├── Bar.qml
│   │   │   │   │   │   │   ├── BarWindow.qml
│   │   │   │   │   │   │   ├── Clock.qml
│   │   │   │   │   │   │   ├── KeebLayout.qml
│   │   │   │   │   │   │   ├── Spacer.qml
│   │   │   │   │   │   │   ├── SysInfo.qml
│   │   │   │   │   │   │   ├── TrayItem.qml
│   │   │   │   │   │   │   ├── Tray.qml
│   │   │   │   │   │   │   └── Workspaces.qml
│   │   │   │   │   │   ├── dashboard
│   │   │   │   │   │   │   ├── dash
│   │   │   │   │   │   │   │   ├── Apps.qml
│   │   │   │   │   │   │   │   ├── BrightnessBar.qml
│   │   │   │   │   │   │   │   ├── Calendar.qml
│   │   │   │   │   │   │   │   ├── DateComp.qml
│   │   │   │   │   │   │   │   └── Weather.qml
│   │   │   │   │   │   │   ├── Button.qml
│   │   │   │   │   │   │   ├── DashBoardLoader.qml
│   │   │   │   │   │   │   ├── DashBoard.qml
│   │   │   │   │   │   │   ├── DashBoardWindow.qml
│   │   │   │   │   │   │   ├── Dash.qml
│   │   │   │   │   │   │   ├── Performance.qml
│   │   │   │   │   │   │   ├── PowerButton.qml
│   │   │   │   │   │   │   ├── PowerWindow.qml
│   │   │   │   │   │   │   └── Weather.qml
│   │   │   │   │   │   ├── media
│   │   │   │   │   │   │   ├── MediaLoader.qml
│   │   │   │   │   │   │   ├── Media.qml
│   │   │   │   │   │   │   ├── MediaWindow.qml
│   │   │   │   │   │   │   ├── Player.qml
│   │   │   │   │   │   │   └── PlayersWindow.qml
│   │   │   │   │   │   └── HotEdges.qml
│   │   │   │   │   ├── utils
│   │   │   │   │   │   ├── Arc.qml
│   │   │   │   │   │   ├── BrightnessData.qml
│   │   │   │   │   │   ├── BrokPlayer.qml
│   │   │   │   │   │   ├── Brok.qml
│   │   │   │   │   │   ├── CircularProgress.qml
│   │   │   │   │   │   ├── CText.qml
│   │   │   │   │   │   ├── F.qml
│   │   │   │   │   │   ├── Func.qml
│   │   │   │   │   │   ├── MaterialIcon.qml
│   │   │   │   │   │   ├── NetworkUsage.qml
│   │   │   │   │   │   ├── PopoutWindow.qml
│   │   │   │   │   │   ├── SparklineItem.qml
│   │   │   │   │   │   ├── SystemInfo.qml
│   │   │   │   │   │   ├── Theme.qml
│   │   │   │   │   │   ├── Time.qml
│   │   │   │   │   │   ├── WeatherData.qml
│   │   │   │   │   │   └── Widget.qml
│   │   │   │   │   ├── Ipc.qml
│   │   │   │   │   └── shell.qml
│   │   │   │   └── default.nix
│   │   │   ├── rofi
│   │   │   │   ├── default.nix
│   │   │   │   └── spotlight-dark.rasi
│   │   │   ├── scripts
│   │   │   │   ├── default.nix
│   │   │   │   ├── default-sink.nix
│   │   │   │   ├── niri.nix
│   │   │   │   ├── niri_workspace_scroll.nix
│   │   │   │   ├── pulse.nix
│   │   │   │   ├── red.nix
│   │   │   │   ├── rgb.nix
│   │   │   │   ├── volSock.nix
│   │   │   │   └── volume.nix
│   │   │   ├── wall
│   │   │   │   ├── wallpapers
│   │   │   │   │   └── wall0.png
│   │   │   │   ├── default.nix
│   │   │   │   └── wall.nix
│   │   │   ├── wayland
│   │   │   │   ├── anyrun.nix
│   │   │   │   ├── default.nix
│   │   │   │   └── fuzzel.nix
│   │   │   ├── x11
│   │   │   │   └── default.nix
│   │   │   ├── dunst.nix
│   │   │   └── picom.nix
│   │   ├── sway
│   │   │   ├── binds.nix
│   │   │   ├── default.nix
│   │   │   └── settings.nix
│   │   └── xfwm
│   │       └── default.nix
│   ├── default.nix
│   └── user_modules.nix
├── hosts
│   ├── 308
│   │   ├── servers
│   │   │   ├── default.nix
│   │   │   └── syncthing.nix
│   │   ├── audio.nix
│   │   ├── boot.nix
│   │   ├── default.nix
│   │   ├── fs.nix
│   │   ├── hardware.nix
│   │   ├── net.nix
│   │   ├── programs.nix
│   │   ├── security.nix
│   │   ├── services.nix
│   │   └── user.nix
│   ├── plier
│   │   ├── servers
│   │   │   ├── default.nix
│   │   │   └── syncthing.nix
│   │   ├── audio.nix
│   │   ├── boot.nix
│   │   ├── default.nix
│   │   ├── fs.nix
│   │   ├── hardware.nix
│   │   ├── net.nix
│   │   ├── programs.nix
│   │   ├── security.nix
│   │   ├── services.nix
│   │   └── user.nix
│   ├── screw
│   │   ├── servers
│   │   │   ├── blocky.nix
│   │   │   ├── caddy.nix
│   │   │   ├── default.nix
│   │   │   ├── forge.nix
│   │   │   ├── freshrss.nix
│   │   │   ├── grafana.nix
│   │   │   ├── kiwix.nix
│   │   │   ├── nfs.nix
│   │   │   ├── nginx.nix
│   │   │   ├── prometheus.nix
│   │   │   └── tailscale.nix
│   │   ├── boot.nix
│   │   ├── default.nix
│   │   ├── fs.nix
│   │   ├── hardware.nix
│   │   ├── net.nix
│   │   ├── security.nix
│   │   ├── services.nix
│   │   └── user.nix
│   ├── shared
│   │   ├── cli
│   │   │   ├── default.nix
│   │   │   ├── yazi.nix
│   │   │   └── zsh.nix
│   │   ├── dev
│   │   │   └── default.nix
│   │   ├── gamer
│   │   │   ├── default.nix
│   │   │   ├── nix-ld.nix
│   │   │   └── steam.nix
│   │   ├── gui
│   │   │   ├── default.nix
│   │   │   ├── fonts.nix
│   │   │   ├── qt.nix
│   │   │   ├── thunar.nix
│   │   │   └── xdg.nix
│   │   ├── virt
│   │   │   └── default.nix
│   │   ├── agenix.nix
│   │   ├── default.nix
│   │   ├── env.nix
│   │   ├── locales.nix
│   │   └── nix.nix
│   ├── vm
│   │   ├── boot.nix
│   │   ├── default.nix
│   │   ├── fs.nix
│   │   ├── net.nix
│   │   ├── security.nix
│   │   ├── services.nix
│   │   └── user.nix
│   └── default.nix
├── lib
│   ├── bindsTranslator.nix
│   ├── default.nix
│   ├── sys_builders.nix
│   ├── utils.nix
│   └── writers.nix
├── modules
│   ├── hm
│   │   ├── cbinds.nix
│   │   └── default.nix
│   └── nixos
│       ├── default.nix
│       └── syncthing.nix
├── secrets
│   ├── freshRSSpass.age
│   ├── git.age
│   ├── leet.age
│   └── secrets.nix
├── templates
│   ├── bb
│   │   └── flake.nix
│   ├── bbe
│   │   └── flake.nix
│   ├── c-make
│   │   ├── flake.nix
│   │   ├── main.c
│   │   ├── Makefile
│   │   └── package.nix
│   ├── rust-parts
│   │   ├── src
│   │   │   └── main.rs
│   │   ├── Cargo.lock
│   │   ├── Cargo.toml
│   │   └── flake.nix
│   └── default.nix
├── devShell.nix
├── flake.lock
├── flake.nix
├── LICENSE
├── overlays.nix
├── README.md
├── shell.nix
└── TODO.md

100 directories, 378 files

```

</details>

# Resources

Resources used in the learning process of making this flake:

- [nyx](https://github.com/NotAShelf/nyx)
- [dotfiles](https://github.com/fufexan/dotfiles)
- [nixpkgs](https://github.com/NixOS/nixpkgs)
- [nix.dev](https://nix.dev)
- [NixOS Options](https://search.nixos.org/options?channel=unstable&type=options)
- [NixOS Packages](https://search.nixos.org/packages?channel=unstable&type=options)
- [Home Manager Options](https://home-manager-options.extranix.com)
- [Nix Function Search](https://noogle.dev)
