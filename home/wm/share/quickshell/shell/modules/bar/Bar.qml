import QtQuick.Layouts
import QtQuick
import qs.utils
import qs.config

Item {
    id: root
    property Config config

    implicitWidth: parent.width
    implicitHeight: parent.height

    function mouseEventHandle(y: real): void {
        if (y > widgets.y) {
            widgets.checkPopout(y - widgets.y);
            return;
        }
        root.config.selected_tray_item = -1;
    }

    ColumnLayout {
        anchors.right: parent.right
        anchors.left: parent.left
        Text {
            text: "yo"
        }
    }

    ColumnLayout {
        id: widgets

        function checkPopout(y: real): void {
            const ch = childAt(16, y) as Widget;
            if (ch == null) {
                root.config.selected_tray_item = -1;
                return;
            }

            if (ch.name == "tray") {
                const tray = ch as Tray;

                const idx = Math.max(Math.floor(((y - tray.y - tray.padding) / tray.implicitHeight) * tray.items.count), 0);
                root.config.selected_tray_item = idx;
            }
        }

        spacing: 2

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Tray {
            name: "tray"
        }
        Clock {
            name: "clock"
        }
    }
}
