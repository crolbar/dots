pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.SystemTray
import QtQuick.Shapes
import QtQuick.Effects
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

    MultiEffect {
        anchors.fill: content
        source: content
        shadowEnabled: true
    }

    Item {
        id: content
        property bool ready: false
        visible: ready

        anchors.fill: parent
        property int arcHeight: 20

        Arc {
            w: content.arcHeight
            h: content.arcHeight
            rev: false
        }
        Arc {
            w: content.arcHeight
            h: content.arcHeight
            rev: true
        }

        Rectangle {
            anchors.fill: parent
            anchors.topMargin: 1 + content.arcHeight
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

                        Behavior on implicitWidth {
                            NumberAnimation {
                                duration: 50
                            }
                        }
                        // Behavior on implicitHeight {
                        //     NumberAnimation {
                        //         duration: 100
                        //     }
                        // }

                        onImplicitHeightChanged: {
                            root.implicitHeight = implicitHeight + 2 + content.arcHeight * 2;
                        }
                        onImplicitWidthChanged: {
                            root.implicitWidth = implicitWidth + 1 + 20; // border + shadow
                        }

                        MouseArea {
                            enabled: loader.index == root.config.selected_tray_item
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
                                cb: b => {
                                    if (content)
                                        content.ready = b;
                                }
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

                                leftMargin: 20
                                rightMargin: -1.5
                                topMargin: -1.5
                                bottomMargin: -1.5
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

    component Arc: Rectangle {
        id: r
        required property int w
        required property int h
        property int sx: 0
        property int sy: 0

        required property bool rev
        implicitWidth: w
        implicitHeight: h

        color: "transparent"

        y: (rev) ? parent.height - h : 0

        z: 1

        Shape {
            ShapePath {
                startX: (r.rev) ? r.w : r.sy
                startY: r.sy
                strokeColor: Theme.bg1
                strokeWidth: 2
                fillColor: Theme.bg1
                PathArc {
                    x: (r.rev) ? r.sx : r.w
                    y: r.h
                    radiusX: r.w
                    radiusY: r.h
                    direction: PathArc.Counterclockwise
                }
                PathLine {
                    x: r.sx
                    y: (r.rev) ? r.sy : r.h
                }
                PathLine {
                    x: (r.rev) ? r.w : r.sx
                    y: r.sy
                }
            }

            ShapePath {
                startX: (r.rev) ? r.w : r.sx
                startY: r.sy
                strokeColor: Theme.yellow0
                strokeWidth: 1.5
                PathArc {

                    x: (r.rev) ? r.sx : r.w
                    y: r.h
                    radiusX: r.w
                    radiusY: r.h
                    direction: PathArc.Counterclockwise
                }
                PathArc {
                    x: (r.rev) ? r.w : r.sx
                    y: r.sy
                    radiusX: r.w
                    radiusY: r.h
                }
            }
        }
    }
}
