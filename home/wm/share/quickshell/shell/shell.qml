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
    }

    // Variants {
    //     model: Quickshell.screens

    //     Scope {
    //         property var modelData

    BarWindow {
        id: bar
        config: root.config
        Component.onCompleted: {
            root.windows[this.name] = this;
        }
        onClosed: {
            visible = false;
        }
    }

    Loader {
        active: root.config.selected_tray_item != -1

        sourceComponent: TrayMenuWindow {
            config: root.config
        }
    }

    Ipc {}
}
