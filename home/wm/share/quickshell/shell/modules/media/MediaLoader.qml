pragma ComponentBehavior: Bound

import QtQuick
import qs.config

Loader {
    id: root
    required property var windows
    required property var niri
    required property Config config

    property string name: "media"
    Component.onCompleted: {
        root.windows[this.name] = this;
    }
    property string ipcToggle: "show"

    // used to unload after the closing animation as `show`
    // and the closing animation are controlled by the same value
    property bool animDone: true
    property bool show: root.config.media_popout_open
    onShowChanged: {
        if (show) {
            if (!root.config.media_popout_open)
                root.config.media_popout_open = true;
            return;
        }

        animDone = false;
        if (root.config.media_popout_open)
            root.config.media_popout_open = false;
    }

    active: {
        if (niri.is_fullscreen)
            return false;

        if (show)
            return true;
        else if (!animDone)
            return true;

        return false;
    }

    sourceComponent: Item {
        MediaWindow {
            config: root.config
            onVisibleChanged: {
                if (!visible)
                    root.animDone = true;
            }
        }
    }

    Loader {
        active: root.config.dashboard_open || root.config.media_popout_open
        sourceComponent: PlayersWindow {
            config: root.config
        }
    }
}
