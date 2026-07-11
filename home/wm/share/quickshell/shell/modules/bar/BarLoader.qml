pragma ComponentBehavior: Bound

import qs.modules.bar.trayMenu
import qs.modules.bar.audio.audioCtl
import QtQuick
import qs.config

Loader {
    id: root
    required property var windows
    required property var niri
    required property Config config

    property string name: "bar"
    Component.onCompleted: {
        root.windows[this.name] = this;
    }
    property string ipcToggle: "show"

    property bool show: true

    active: !root.niri.is_fullscreen && show

    sourceComponent: Item {
        BarWindow {
            id: bar
            config: root.config
            niri: root.niri
        }

        TrayMenuWindow {
            id: tmw
            config: root.config
        }

        AudioCtlWindow {
            config: root.config
        }
    }
}
