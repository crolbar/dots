import Quickshell
import QtQuick.Layouts
import QtQuick

Item {
    implicitWidth: parent.width
    implicitHeight: parent.height

    ColumnLayout {
    }

    ColumnLayout {
        id: layout

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Clock {}
    }
}
