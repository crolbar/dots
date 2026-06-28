pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Widgets
import Quickshell.Services.SystemTray

MouseArea {
    id: root

    required property SystemTrayItem modelData

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    implicitWidth: 22
    implicitHeight: 22

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

    IconImage {
        id: symbolic
        asynchronous: true

        visible: status === Image.Ready
        anchors.fill: parent
        source: root.source
    }

    Loader {
        active: symbolic.status === Image.Error
        anchors.fill: parent
        asynchronous: true
        sourceComponent: IconImage {
            source: root.source
        }
    }
}
