pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import qs.modules.bar
import qs.modules.bar.trayMenu
import qs.modules.bar.audio
import qs.config

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
        id: l
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

    TrayMenuWindow {
        id: tmw
        config: root.config
    }

    AudioCtlWindow {
        config: root.config
    }

    Ipc {}
}
