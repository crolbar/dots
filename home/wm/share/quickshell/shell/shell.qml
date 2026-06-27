import Quickshell
import QtQuick
import qs.modules.bar

ShellRoot {
    id: root
    property var windows: ({})

    // Variants {
    //     model: Quickshell.screens

    //     Scope {
    //         property var modelData
    BarWindow {
        // screen: modelData
        Component.onCompleted: {
            root.windows[this.name] = this;
        }
        onClosed: {
            visible = false;
        }
    }
    //     }
    // }

    // W {
    //     screen: modelData
    //     Component.onCompleted: {
    //         root.windows[this.name] = this;
    //     }
    //     onClosed: {
    //         visible = false;
    //     }
    // }

    Ipc {}
}
