pragma ComponentBehavior: Bound

import qs.utils
import QtQuick.Layouts
import QtQuick
import Quickshell.Services.Pipewire

Widget {
    implicitWidth: 32
    implicitHeight: loader.implicitHeight

    color: "transparent"

    Loader {
        id: loader
        active: Pipewire.ready
        sourceComponent: ColumnLayout {
            id: layout
            anchors.horizontalCenter: parent.horizontalCenter

            Source {}
            Sink {}
        }
    }
}
