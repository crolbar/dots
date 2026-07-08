import QtQuick
import qs.utils
import qs.config

Rectangle {
    id: root
    required property Config config

    implicitHeight: implicitWidth
    implicitWidth: icon.width + 16
    anchors.centerIn: parent

    radius: 30
    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            root.config.power_popout_open = !root.config.power_popout_open;
            root.config.power_popout_x = mapToItem(null, 0, 0).x + (root.implicitWidth / 2);
        }
    }

    color: (ma.containsMouse) ? Theme.bg1 : "transparent"

    MaterialIcon {
        id: icon
        anchors.centerIn: parent
        color: Theme.red0
        text: "power_settings_new"
        font.pixelSize: 32
    }
}
