pragma ComponentBehavior: Bound

/*

Structure of windows:
modules/*       directory that containts files associated with that window, it most likely will contain these main files:
 *Loader        controlling whether the window is loaded in memory, also likely registers in `windows` for ipc control
 *Window        *Window type containing basic properties, hover handlers...
 *              should be the root component in the window, containing all the contents visible in the window
*/

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
        command: ["sh", "-c", "~/scripts/niri.sh"]

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
