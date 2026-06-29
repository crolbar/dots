pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import qs.utils

Widget {
    id: root

    required property var workspaces
    implicitWidth: 32
    implicitHeight: layout.implicitHeight
    color: "transparent"

    readonly property int padding: 4

    Column {
        id: layout
        anchors.horizontalCenter: root.horizontalCenter
        anchors.top: parent.top

        Repeater {
            model: root.workspaces

            Rectangle {
                id: item
                required property var modelData
                color: (mouseArea.containsMouse) ? Theme.bg1 : "transparent"
                implicitWidth: 32
                implicitHeight: text.implicitHeight + root.padding

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent
                    onClicked: {
                        focus.idx = item.modelData.idx;
                        focus.running = true;
                    }
                    Process {
                        id: focus
                        running: false
                        property int idx
                        command: {
                            ["sh", "-c", `niri msg action focus-workspace ${idx}`];
                        }
                    }
                    hoverEnabled: true

                    Text {
                        id: text
                        Layout.alignment: Qt.AlignHCenter
                        anchors.centerIn: parent

                        color: (item.modelData.is_focused) ? Theme.green0 : Theme.bg3
                        font.pixelSize: 16
                        font.bold: true

                        text: item.modelData.name
                    }
                }
            }
        }
    }
}
