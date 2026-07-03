import QtQuick
import Quickshell.Services.Pipewire
import qs.config

MouseArea {
    id: root
    required property PwNode device
    required property Config config

    anchors.fill: parent

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    onClicked: me => {
        if (me.button == Qt.LeftButton) {
            device.audio.muted = !device.audio.muted;
        } else if (me.button == Qt.RightButton) {
            root.config.bar_popout_audio_ctl_open = !root.config.bar_popout_audio_ctl_open
            root.config.bar_popout_audio_ctl_center_y = root.config.bar_height - mapToItem(null, me.x, me.y).y
        }
    }

    cursorShape: Qt.PointingHandCursor
}
