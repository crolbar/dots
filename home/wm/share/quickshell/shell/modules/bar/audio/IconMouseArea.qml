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
            for (var node of Pipewire.nodes.values.filter(n => n.isSink && n.type == 17)) {
                if (node.name != device.name) {
                    Pipewire.preferredDefaultAudioSink = node;
                    return;
                }
            }
        }
    }

    cursorShape: Qt.PointingHandCursor
}
