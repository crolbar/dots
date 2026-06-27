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

    // function getTrayIcon(id: string, icon: string): string {
    //     // if (icon.includes("?path=")) {
    //     //     const [name, path] = icon.split("?path=");
    //     //     icon = Qt.resolvedUrl(`${path}/${name.slice(name.lastIndexOf("/") + 1)}`);
    //     // }
    //     return icon;
    // }

    IconImage {
        id: symbolic
        asynchronous: true

        visible: status === Image.Ready
        anchors.fill: parent
        source: root.modelData.icon + "-symbolic"
    }

    Loader {
        active: symbolic.status === Image.Error
        anchors.fill: parent
        asynchronous: true
        sourceComponent: IconImage {
            source: root.modelData.icon
        }
    }
}
