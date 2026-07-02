import qs.utils
import qs.config
import QtQuick

PopoutWindow {
    id: root
    required property Config config
    side: PopoutWindow.Side.Left
    anchors.bottom: true

    margins {
        bottom: Math.max(config.bar_popout_audio_ctl_center_y - (root.implicitHeight / 2), 0)
        left: 32
    }
    expanded: config.bar_popout_audio_ctl_open

    comp: Item {
        implicitHeight: 50
        implicitWidth: 150

        Rectangle {
            anchors.fill: parent
            color: "blue"
        }
    }
}
