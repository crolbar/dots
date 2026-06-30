pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.modules.bar
import qs.modules.trayMenu
import qs.config
import qs.utils

ShellRoot {
    id: root
    property var windows: ({})
    property Config config: Config {
        selected_tray_item: -1
    }

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

    PopoutWindow {
        w: 400
        h: 100
        side: PopoutWindow.Top
        shadowEnabled: true

        // anchors.left: true
        // margins.left: 700

    }

    Ipc {}
}
