pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.SystemTray
import QtQuick.Shapes
import QtQuick
import qs.config
import qs.utils

// qmllint disable uncreatable-type
PanelWindow {
    id: root

    property Config config
    exclusionMode: ExclusionMode.Ignore

    margins.bottom: Math.max(config.selected_tray_item_center_y - (root.implicitHeight / 2), 0)
    margins.left: 31

    anchors.left: true
    anchors.bottom: true

    color: "transparent"

    Item {
        id: content
        property bool ready: false
        visible: ready

        Rectangle {
            id: r
            property int w: 20
            property int h: 20

            implicitWidth: w
            implicitHeight: h

            color: "transparent"

            anchors.bottomMargin: 20
            z: 1

            Shape {
                ShapePath {
                    startX: 0
                    startY: 0
                    strokeColor: Theme.bg1
                    strokeWidth: 2
                    fillColor: Theme.bg1
                    PathArc {
                        x: r.w
                        y: r.h
                        radiusX: r.w
                        radiusY: r.h
                        direction: PathArc.Counterclockwise
                    }
                    PathLine {
                        x: 0
                        y: r.h
                    }
                    PathLine {
                        x: 0
                        y: 0
                    }
                }

                ShapePath {
                    startX: 0
                    startY: 0
                    strokeColor: Theme.yellow0
                    PathArc {

                        x: r.w
                        y: r.h
                        radiusX: r.w
                        radiusY: r.h
                        direction: PathArc.Counterclockwise
                    }
                    PathArc {
                        x: 0
                        y: 0
                        radiusX: r.w
                        radiusY: r.h
                        // direction: PathArc.Counterclockwise
                    }
                }
            }
        }

        Rectangle {
            anchors.fill: parent
            anchors.topMargin: 21
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

                        bottomRightRadius: 10
                        topRightRadius: 10

                        color: Theme.bg1
                        implicitHeight: trayMenu.currentHeight
                        implicitWidth: trayMenu.currentWidth
                        onImplicitHeightChanged: {
                            root.implicitHeight = implicitHeight + 2 + 20;
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
                                cb: b => content.ready = b
                            }
                        }

                        // border over the tray menu excluding the left one
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
}
