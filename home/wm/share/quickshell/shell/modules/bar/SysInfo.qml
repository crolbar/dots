import qs.utils
import QtQuick.Layouts
import QtQuick
import qs.modules.bar

Widget {
    id: root
    implicitWidth: 32

    implicitHeight: layout.implicitHeight

    color: "transparent"

    Component.onCompleted: SystemInfo.start()

    Behavior on implicitHeight {
        NumberAnimation {
            id: hAnim
            duration: 200
        }
    }

    ColumnLayout {
        id: layout
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: 32
        spacing: 4

        Text {
            Layout.alignment: Qt.AlignCenter
            color: Theme.purple0
            text: `${SystemInfo.gpuUtil}`
        }

        Text {
            Layout.alignment: Qt.AlignCenter
            color: (SystemInfo.vramUsage > 13) ? Theme.red1 : Theme.yellow0
            text: `${SystemInfo.vramUsage}`
        }

        Text {
            Layout.alignment: Qt.AlignCenter
            color: ((SystemInfo.gpuTemp) > 65) ? Theme.red1 : Theme.green0
            text: `${SystemInfo.gpuTemp}`
        }

        Spacer {}

        Text {
            Layout.alignment: Qt.AlignCenter
            visible: (SystemInfo.cpuUsage) < 100
            color: Theme.orange0
            text: `${SystemInfo.cpuUsage}`
        }

        Text {
            Layout.alignment: Qt.AlignCenter
            color: (SystemInfo.memUsage > 18) ? Theme.red1 : Theme.yellow0
            text: `${SystemInfo.memUsage}`
        }

        Text {
            Layout.alignment: Qt.AlignCenter
            color: (SystemInfo.cpuTemp > 68) ? Theme.red1 : Theme.green0
            text: `${SystemInfo.cpuTemp}`
        }
    }
}
