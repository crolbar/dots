import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import qs.utils

Widget {
    id: root
    property var niri: null
    Process {
        id: proc
        command: ["sh", "-c", "~/.config/niri/eww/scripts/niri"]

        running: true

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: d => root.niri = JSON.parse(d)
        }
    }

    implicitWidth: 32
    implicitHeight: layout.implicitHeight
    color: "transparent"

    readonly property int padding: 4
    readonly property int spacing: 4

    Column {
        id: layout
        anchors.horizontalCenter: root.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: root.padding
        spacing: root.spacing

        Repeater {
            model: root.niri.workspaces

            Rectangle {
                id: item
                required property var modelData
                color: "transparent"
                implicitWidth: 32
                implicitHeight: text.implicitHeight

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
