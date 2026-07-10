pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import qs.modules.bar
import qs.modules.bar.trayMenu
import qs.modules.bar.audio.audioCtl
import qs.modules.dashboard
import qs.modules.media
import qs.modules
import qs.config
import qs.utils

ShellRoot {
    id: root
    property var windows: ({})
    property Config config: Config {
        selected_tray_item: -1
        bar_popout_border_visible: false
    }

    property var niri: ({
            workspaces: [],
            kb_layout: ""
        })

    Process {
        id: proc
        command: ["sh", "-c", "~/.config/niri/eww/scripts/niri"]

        running: true

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: d => root.niri = JSON.parse(d)
        }
    }

    Loader {
        // NOTE: add when !fullscreen (or wait untill niri adds fullscreen state in ipc... https://github.com/niri-wm/niri/discussions/1843)
        id: barLoader
        property string name: "bar"
        Component.onCompleted: {
            root.windows[this.name] = this;
        }
        property string ipcToggle: "active"
        sourceComponent: BarWindow {
            id: bar
            config: root.config
            niri: root.niri
        }
    }

    Loader {
        active: barLoader.active
        sourceComponent: TrayMenuWindow {
            id: tmw
            config: root.config
        }
    }

    Loader {
        active: barLoader.active
        sourceComponent: AudioCtlWindow {
            config: root.config
        }
    }

    Loader {
        property string name: "hotEdges"
        Component.onCompleted: {
            root.windows[this.name] = this;
        }
        property string ipcToggle: "active"
        active: true
        sourceComponent:
        HotEdges {
            config: root.config
            onDashBoard: () => dashBoardLoader.shown = true
        }
    }

    Loader {
        id: dashBoardLoader
        property string name: "dashboard"
        Component.onCompleted: {
            root.windows[this.name] = this;
        }
        property string ipcToggle: "shown"

        active: false

        // on true: active = true -> item.expanded = true
        // on false: expanded = false -> on item.visible == false -> active = false
        property bool shown: false
        onShownChanged: {
            if (shown) {
                active = true;
                return;
            }

            if (item)
                item.expanded = false;
        }
        onActiveChanged: {
            if (active)
                item.expanded = true;
        }
        sourceComponent: DashBoardWindow {
            config: root.config
            // called after expanded == false
            onVisibleChanged: {
                if (visible)
                    return;

                dashBoardLoader.active = false;
                dashBoardLoader.shown = false;
            }
        }
    }

    Loader {
        active: dashBoardLoader.active
        sourceComponent: PowerWindow {
            config: root.config
        }
    }

    Loader {
        id: mediaLoader
        property string name: "media"
        Component.onCompleted: {
            root.windows[this.name] = this;
        }
        property string ipcToggle: "show"

        property bool show: root.config.media_popout_open
        onShowChanged: {
            if (show) {
                active = true;
                if (!root.config.media_popout_open)
                    root.config.media_popout_open = true;
                return;
            }

            if (root.config.media_popout_open)
                root.config.media_popout_open = false;
        }

        active: false
        sourceComponent: MediaWindow {
            config: root.config
            onVisibleChanged: {
                if (!visible)
                    mediaLoader.active = false;
            }
        }
    }

    Loader {
        active: dashBoardLoader.active || root.config.media_popout_open
        sourceComponent: PlayersWindow {
            config: root.config
        }
    }

    Component.onCompleted: {
        Brok.config = root.config;
        Brok.start();
    }

    Component.onDestruction: {
        Brok.stop();
    }

    Ipc {}
}
