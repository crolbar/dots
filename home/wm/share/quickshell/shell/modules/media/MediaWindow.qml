pragma ComponentBehavior: Bound

import QtQuick
import qs.utils
import qs.config

PopoutWindow {
    id: root
    required property Config config

    side: PopoutWindow.Side.Right

    anchors.top: true
    margins.top: 15

    // bind later so it gets from false -> true when
    // we are using media_popout_open for the active of the loader
    Component.onCompleted: {
        expanded = Qt.binding(() => config.media_popout_open);
        root.config.media_popout_closing_timer = closingTimer
    }

    bgColor: Theme.bg0
    borderColor: Theme.bg0

    arcWidth: 12
    arcHeight: 12

    animationDuration: 150
    animationType: Easing.BezierSpline
    animationCurve: [0.38, 1.21, 0.22, 1, 1, 1]

    HoverHandler {
        onHoveredChanged: closingTimer.running = !hovered && !root.config.media_focus_popout_open
    }

    Timer {
        id: closingTimer
        interval: 1500
        onTriggered: root.config.media_popout_open = false
        Component.onCompleted: running = true
    }

    comp: Item {
        implicitHeight: 280
        implicitWidth: 180

        Media {
            id: media
            config: root.config
        }
    }
}
