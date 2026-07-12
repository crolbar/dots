pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.config

Loader {
    id: root
    required property Config config
    required property var niri
    required property var onDashBoard

    active: !niri.is_fullscreen

    // qmllint disable uncreatable-type
    sourceComponent: PanelWindow {
        id: dashboard
        exclusionMode: ExclusionMode.Ignore
        anchors.top: true
        implicitWidth: 100
        implicitHeight: 2

        color: "transparent"

        property int entryX: -1
        HoverHandler {
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
