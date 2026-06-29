import qs.utils
import QtQuick
import Quickshell.Services.Pipewire

AudioDevice {
    id: root
    implicitHeight: icon.height
    implicitWidth: icon.width
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSource]
    }
    device: Pipewire.defaultAudioSource

    MaterialIcon {
        id: icon
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        IconMouseArea {
            device: root.device
        }

        font.pixelSize: 20

        Behavior on color {
            ColorAnimation {
                duration: 250
            }
        }

        color: (root.device.audio.muted) ? Theme.blue1 : Theme.red0

        text: (root.device.audio.muted) ? "mic_off" : "mic"
    }
}
