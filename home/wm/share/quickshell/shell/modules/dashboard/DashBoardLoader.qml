pragma ComponentBehavior: Bound

import QtQuick
import qs.config

Loader {
    id: root
    required property var windows
    required property Config config

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

        root.config.dashboard_open = false;
    }
    onActiveChanged: {
        if (active)
            root.config.dashboard_open = true;
    }
    sourceComponent: Item {
        DashBoardWindow {
            config: root.config
            // called after expanded == false
            onVisibleChanged: {
                if (visible)
                    return;

                root.active = false;
                root.shown = false;
            }
        }

        PowerWindow {
            config: root.config
        }
    }
}
