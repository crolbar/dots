pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.config

Loader {
    id: root
    required property Config config
    required property var niri
    required property var onDashBoard
    required property var onBar

    active: !niri.is_fullscreen

    // qmllint disable uncreatable-type
    sourceComponent: Item {
        PanelWindow {
            id: bar
            exclusionMode: ExclusionMode.Ignore
            anchors.left: true
            anchors.top: true
            anchors.bottom: true
            implicitWidth: 1

            color: "transparent"

            HoverHandler {
                id: barhh
                onHoveredChanged: {
                    if (root.config.bar_pinned)
                        return;

                    if (hovered) {
                        root.onBar();
                    }
                }
            }
        }

        PanelWindow {
            id: dashboard
            exclusionMode: ExclusionMode.Ignore
            anchors.top: true
            implicitWidth: 100
            implicitHeight: 2

            color: dasdboardhh.hovered ? "#70e03232" : "transparent"

            property int entryX: -1
            HoverHandler {
                id: dasdboardhh
                onHoveredChanged: {
                    if (hovered) {
                        dashboard.entryX = point.position.x;
                    } else {
                        if (dashboard.entryX == -1)
                            return;

                        // right swipe
                        if (dashboard.entryX < 5 && point.position.x > 95)
                            root.onDashBoard();

                        // left swipe
                        if (dashboard.entryX > 95 && point.position.x < 5)
                            root.onDashBoard();
                    }
                }
            }
        }
    }
}
