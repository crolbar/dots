pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.utils
import qs.config

PopoutWindow {
    id: root
    required property Config config

    side: PopoutWindow.Side.Top

    anchors.right: true

    margins {
        top: 400
        right: {
            return (screen.width / 2) - // mid screen
            (width / 2) + // mid of window is on mid screen
            (770 / 2) - // start of dashboard
            config.power_popout_x - 1;
        }
    }

    arcHeight: 10
    arcWidth: 10
    arc2Height: 10
    arc2Width: 10

    bgColor: Theme.bg0
    borderColor: Theme.bg0

    animationDuration: 300
    animationType: Easing.BezierSpline
    animationCurve: [0.38, 1.21, 0.22, 1, 1, 1]

    expanded: config.power_popout_open

    comp: Item {
        implicitHeight: 200
        implicitWidth: 38

        ColumnLayout {
            anchors.topMargin: 8
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            spacing: 8

            PowerIconButton {
                onClicked: () => {
                    Quickshell.execDetached({
                        command: ["systemctl", "suspend"]
                    });
                }
                colour: Theme.purple0
                text: "bedtime"
            }
            PowerIconButton {
                onClicked: () => {
                    Quickshell.execDetached({
                        command: ["swaylock", "-c", "000000", "-l", "--ring-color", "8e6e9c", "--key-hl-color", "dba8f3"]
                    });
                }
                colour: Theme.blue0
                text: "lock"
            }
            PowerIconButton {
                onClicked: () => {
                    Quickshell.execDetached({
                        command: ["reboot"]
                    });
                }
                colour: Theme.orange0
                text: "restart_alt"
            }
            PowerIconButton {
                onClicked: () => {
                    Quickshell.execDetached({
                        command: ["poweroff"]
                    });
                }
                colour: Theme.red0
                text: "power_off"
            }
        }
    }

    component PowerIconButton: Rectangle {
        id: pib
        required property string text
        required property color colour
        required property var onClicked

        implicitHeight: icon.height
        Layout.fillWidth: true

        color: (ma.containsMouse) ? Theme.bg1 : "transparent"

        radius: 18

        MouseArea {
            id: ma
            hoverEnabled: true
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                pib.onClicked();
                root.config.power_popout_open = false;
            }
        }

        MaterialIcon {
            id: icon
            anchors.centerIn: parent
            color: pib.colour
            text: pib.text
            font.pixelSize: 32
        }
    }
}
