pragma ComponentBehavior: Bound

import Quickshell
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
                            const niri_cmd = `niri msg action focus-workspace ${idx}`;
                            const red_cmd = `echo "focus_n ${idx}" | socat -u - UNIX-CONNECT:$RED_SOCKET`;
                            ["sh", "-c", (Quickshell.env("RED_SOCKET")) ? red_cmd : niri_cmd];
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

                        text: {
                            if (Quickshell.env("RED_SOCKET")) {
                                return parseInt(item.modelData.idx) + 1;
                            }
                            return item.modelData.name;
                        }
                    }
                }
            }
        }
    }
}
