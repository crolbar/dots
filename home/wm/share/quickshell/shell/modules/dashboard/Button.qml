import QtQuick

Rectangle {
    id: root
    required property var onClick
    property bool hovered: ma.containsMouse

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.onClick()
        cursorShape: Qt.PointingHandCursor
    }
}
