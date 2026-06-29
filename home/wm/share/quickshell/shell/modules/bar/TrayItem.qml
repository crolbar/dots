pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import qs.utils

MouseArea {
    id: root

    required property SystemTrayItem modelData

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    implicitWidth: 32
    implicitHeight: 32

    hoverEnabled: true

    onClicked: event => {
        if (event.button === Qt.LeftButton)
            modelData.activate();
        else
            modelData.secondaryActivate();
    }

    function getTrayIcon(icon: string): string {
        if (icon.includes("spotify") && icon.includes("symbolic")) {
            return null;
        }

        if (icon.includes("?path=") && !icon.includes("steam")) {
            const [name, path] = icon.split("?path=");
            icon = Qt.resolvedUrl(`${path}/${name.slice(name.lastIndexOf("/") + 1)}`);
        }
        return icon;
    }

    property string source: {
        const symb = root.getTrayIcon(root.modelData.icon + "-symbolic");
        if (symb != "null") {
            return symb;
        }
        return root.getTrayIcon(root.modelData.icon);
    }

    Rectangle {
        anchors.fill: parent
        visible: root.containsMouse

        radius: 10
        color: Theme.bg0
    }

    IconImage {
        id: symbolic
        asynchronous: true
        implicitHeight: 22
        implicitWidth: 22
        anchors.centerIn: parent
        source: root.source
    }
}
