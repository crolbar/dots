import QtQuick
import Quickshell.Services.SystemTray
import qs.utils

Widget {
    id: root

    readonly property alias items: items

    readonly property int padding: 4
    readonly property int spacing: 4

    property bool expanded

    readonly property real nonAnimHeight: layout.implicitHeight + padding * 2

    clip: true

    implicitWidth: 32
    implicitHeight: nonAnimHeight

    radius: 8
    color: Theme.bg1

    Column {
        id: layout

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: root.padding
        spacing: root.spacing

        // add: Transition {
        //     Anim {
        //         properties: "scale"
        //         from: 0
        //         to: 1
        //         easing: Tokens.anim.standardDecel
        //     }
        // }

        // move: Transition {
        //     Anim {
        //         properties: "scale"
        //         to: 1
        //         easing: Tokens.anim.standardDecel
        //     }
        //     Anim {
        //         properties: "x,y"
        //     }
        // }

        Repeater {
            id: items
            model: SystemTray.items.values
            TrayItem {}
        }
    }

    // Behavior on implicitHeight {
    //     Anim {}
    // }
}
