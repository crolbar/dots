pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import qs.modules.bar
import qs.modules.dashboard
import qs.modules.media
import qs.modules
import qs.config
import qs.utils

ShellRoot {
    id: root
    property var windows: ({})
    property Config config: Config {}
    property var niri: ({
            workspaces: [],
            kb_layout: ""
        })

    BarLoader {
        id: barLoader
        windows: root.windows
        config: root.config
        niri: root.niri
    }

    DashBoardLoader {
        id: dashBoardLoader
        windows: root.windows
        config: root.config
    }

    MediaLoader {
        id: mediaLoader
        windows: root.windows
        config: root.config
        niri: root.niri
    }

    HotEdges {
        config: root.config
        niri: root.niri
        onDashBoard: () => dashBoardLoader.shown = true
    }

    Process {
        id: proc
        command: ["sh", "-c", "~/.config/niri/eww/scripts/niri"]

        running: true

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: d => root.niri = JSON.parse(d)
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
