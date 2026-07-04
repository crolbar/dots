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
    onVisibleChanged: {
        if (root.config.bar_popout_border_visible_for == "tray") {
            if (!visible)
                root.config.bar_popout_border_visible_for = "";
            root.config.bar_popout_border_visible = visible;
        }
    }

    borderColor: Theme.yellow0
    bgColor: Theme.bg1

    arcWidth: 25
    arcHeight: 25

    arc2Width: 15
    arc2Height: 15

    animationDuration: 150

    HoverHandler {
        onHoveredChanged: {
            // don't care about enter
            if (hovered)
                return;

            const x = point.position.x;
            // moving to bar, don't handle unselecting of tray item, bar will
            if (x < 2)
                return;
            if (root.config.selected_tray_item_noexit)
                return;
            root.config.selected_tray_item = -1;
        }
    }

    comp: Item {
        id: contents
        property int padding: 12

        implicitHeight: {
            if (!loader.item || loader.item.currentItem.implicitHeight <= 0)
                return implicitHeight;
            return loader.item.currentItem.implicitHeight + padding * 2;
        }
        implicitWidth: {
            if (!loader.item || loader.item.currentItem.implicitWidth <= 0)
                return implicitWidth;
            return loader.item.currentItem.implicitWidth + padding * 2 + 40;
        }

        Loader {
            id: loader
            property var selItem: SystemTray.items.values[root.config.last_selected_tray_item]
            active: selItem != undefined

            anchors.top: contents.top
            anchors.left: contents.left
            anchors.leftMargin: contents.padding
            anchors.topMargin: contents.padding

            sourceComponent: TrayMenu {
                id: trayMenu
                config: root.config
                initialHandle: loader.selItem.menu // qmllint disable unresolved-type
            }
        }
    }
}
