pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Widgets
import Quickshell
import QtQuick.Layouts
import qs.utils

RowLayout {
    id: layout

    anchors.centerIn: parent
    anchors.left: parent.left

    CustomIcon {
        cmd: "steam"
        source: "image://icon/steam_tray_mono"
    }

    CustomIcon {
        cmd: "thunar"
        source: "file:///run/current-system/sw/share/icons/hicolor/scalable/apps/org.xfce.thunar.svg"
    }

    CustomIcon {
        cmd: "obsidian"
        source: "image://icon/obsidian"
    }

    CustomIcon {
        cmd: "vesktop"
        source: "image://icon/discord"
    }

    CustomIcon {
        cmd: "spotify"
        source: "image://icon/spotify"
    }

    component CustomIcon: Rectangle {
        id: ci
        required property string cmd
        required property string source

        implicitHeight: 32
        implicitWidth: 32

        color: (ma.containsMouse) ? Theme.bg2 : "transparent"

        radius: 5

        MouseArea {
            id: ma
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                Quickshell.execDetached({
                    command: ci.cmd
                });
            }
            cursorShape: Qt.PointingHandCursor
        }

        IconImage {
            asynchronous: true
            implicitHeight: 32
            implicitWidth: 32
            source: ci.source
        }
    }
}
