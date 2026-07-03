import QtQuick
import qs.utils

Rectangle {
    id: root
    required property double volume
    required property color siliderColor
    required property var handlePressed
    required property var handleReleased
    required property var handleWheel
    property double lastPressX: 0.0
    anchors.fill: parent
    radius: 8
    color: Theme.bg1

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onPressed: me => root.handlePressed(me)
        onReleased: me => root.handleReleased(me)
        onWheel: me => root.handleWheel(me)
    }

    Rectangle {
        id: slider
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        radius: root.radius

        implicitWidth: parent.width * root.volume
        color: root.siliderColor
    }

    Behavior on volume {
        NumberAnimation {
            duration: 100
        }
    }
}
