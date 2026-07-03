import qs.utils
import QtQuick

Rectangle {
    id: root
    required property bool val
    required property var onClick
    required property string iconText
    required property color iconColor
    implicitWidth: muteIcon.width + 8

    color: (ma.containsMouse) ? Theme.bg2 : Theme.bg1
    radius: 5

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.onClick();
        }
        cursorShape: Qt.PointingHandCursor
    }

    MaterialIcon {
        id: muteIcon
        font.pixelSize: 16
        anchors.centerIn: parent
        color: root.iconColor
        text: root.iconText
    }
}
