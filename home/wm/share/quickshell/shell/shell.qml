pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.modules.bar
import qs.modules.trayMenu
import qs.config

ShellRoot {
    id: root
    property var windows: ({})
    property Config config: Config {
        selected_tray_item: -1
        last_selected_tray_item: 0
        bar_popout_border_visible: false
    }

    Loader {
        // TODO: add when !fullscreen
        active: true
        property string name: "bar"
        Component.onCompleted: {
            root.windows[this.name] = this;
        }
        property string ipcToggle: "active"
        sourceComponent: BarWindow {
            id: bar
            config: root.config
        }
    }

    TrayMenuWindow {
        id: tmw
        config: root.config
    }

    Ipc {}
}
