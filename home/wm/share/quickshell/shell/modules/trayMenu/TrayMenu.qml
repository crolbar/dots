pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import qs.config

PanelWindow {
    id: root

    property Config config

    exclusionMode: ExclusionMode.Ignore
    anchors.left: true
    anchors.bottom: true

    margins.left: 30

    implicitHeight: layout.implicitHeight
    implicitWidth: layout.implicitWidth

    QsMenuOpener {
        id: menuOpener

        menu: SystemTray.items.values[root.config.selected_tray_item].menu
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onExited: () => {
            root.config.selected_tray_item = -1;
        }

        ColumnLayout {
            id: layout

            Repeater {
                model: menuOpener.children

                Text {
                    id: item
                    required property QsMenuEntry modelData

                    text: modelData.text
                }
            }
        }
    }
}
