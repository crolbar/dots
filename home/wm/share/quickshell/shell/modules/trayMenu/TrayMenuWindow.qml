import Quickshell.Services.SystemTray
import QtQuick
import qs.config
import qs.utils

PopoutWindow {
    id: root
    required property Config config

    side: PopoutWindow.Side.Left
    anchors.bottom: true

    // qmllint disable missing-property unresolved-type unqualified
    margins {
        bottom: Math.max(config.selected_tray_item_center_y - (root.implicitHeight / 2), 0)
        left: 32
    }

    Behavior on margins.bottom {
        NumberAnimation {
            duration: root.animationDuration
        }
    }

    expanded: config.selected_tray_item != -1
    onVisibleChanged: root.config.bar_popout_border_visible = visible

    borderColor: Theme.yellow0
    bgColor: Theme.bg1

    arcWidth: 25
    arcHeight: 25

    arc2Width: 15
    arc2Height: 15

    animationDuration: 150

    comp: Item {
        id: contents
        property int padding: 12

        implicitHeight: {
            if (trayMenu.currentItem.implicitHeight <= 0)
                return implicitHeight;
            return trayMenu.currentItem.implicitHeight + padding*2;
        }
        implicitWidth: {
            if (trayMenu.currentItem.implicitWidth <= 0)
                return implicitWidth;
            return trayMenu.currentItem.implicitWidth + padding*2 + 40;
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onExited: () => {
                // moving to bar, don't handle unselecting of tray item, bar will
                if (mouseX < 2)
                    return;
                if (root.config.selected_tray_item_noexit)
                    return;
                root.config.selected_tray_item = -1;
            }

            TrayMenu {
                id: trayMenu
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: contents.padding
                anchors.topMargin: contents.padding
                config: root.config
                initialHandle: SystemTray.items.values[root.config.last_selected_tray_item].menu // qmllint disable unresolved-type
            }
        }
    }
}
