pragma ComponentBehavior: Bound

import qs.utils
import QtQuick.Layouts
import QtQuick
import Quickshell.Services.Pipewire
import qs.config

Widget {
    id: root
    required property Config config

    implicitWidth: 32
    implicitHeight: loader.implicitHeight + 8

    color: "transparent"

    Loader {
        id: loader
        active: Pipewire.ready
        anchors.centerIn: parent
        sourceComponent: ColumnLayout {
            id: layout
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.implicitWidth
            spacing: 0

            Source {
                config: root.config
            }
            Sink {
                config: root.config
            }
        }
    }
}
