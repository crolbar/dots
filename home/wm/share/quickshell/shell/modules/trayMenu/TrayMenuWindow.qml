pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import qs.config
import qs.utils

// qmllint disable uncreatable-type
PanelWindow {
    id: root

    property Config config
    exclusionMode: ExclusionMode.Ignore

    margins.bottom: Math.max(config.selected_tray_item_center_y - (root.implicitHeight / 2), 0)
    margins.left: 30

    anchors.left: true
    anchors.bottom: true

    color: "transparent"

    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 1
        color: "transparent"

        Repeater {
            id: repeater
            model: SystemTray.items.values

            Loader {
                id: loader
                required property SystemTrayItem modelData
                required property int index

                active: index == root.config.selected_tray_item

                sourceComponent: Rectangle {
                    id: rect
                    // radius: 10

                    bottomRightRadius: 10
                    topRightRadius: 10

                    anchors.topMargin: 1

                    color: Theme.bg1
                    implicitHeight: trayMenu.currentHeight
                    implicitWidth: trayMenu.currentWidth
                    onImplicitHeightChanged: {
                        root.implicitHeight = implicitHeight + 2;
                    }
                    onImplicitWidthChanged: {
                        root.implicitWidth = implicitWidth + 1;
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
                            config: root.config
                            initialHandle: loader.modelData.menu // qmllint disable unresolved-type
                        }
                    }

                    Rectangle {
                        z: -1

                        anchors {
                            // fill: parent
                            top: parent.top
                            right: parent.right
                            bottom: parent.bottom
                            left: parent.left

                            rightMargin: -1
                            topMargin: -1
                            bottomMargin: -1
                        }

                        bottomRightRadius: 10
                        topRightRadius: 10

                        color: Theme.yellow0
                    }
                }
            }
        }
    }
}
