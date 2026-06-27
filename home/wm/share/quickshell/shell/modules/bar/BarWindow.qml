import Quickshell
import QtQuick
import qs.utils

// qmllint disable uncreatable-type
PanelWindow {
    id: bar
    property string name: "bar"
    // + ((screen.name == "DP-1") ? "" : "-" + screen.name)

    color: Theme.bg0

    anchors {
        top: true
        left: true
        bottom: true
    }

    implicitWidth: 32

    Bar {}
}
