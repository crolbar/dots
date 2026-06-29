import qs.utils
import QtQuick
import Quickshell.Services.Pipewire

AudioDevice {
    id: root
    property string icon: {
        if (device.name.includes("G533")) {
            if (device.audio.muted) {
                return "headset_off";
            } else {
                return "headphones";
            }
        } else {
            if (device.audio.muted) {
                return "volume_off";
            } else {
                if (device.audio.volume > 0.6) {
                    return "volume_up";
                } else if (device.audio.volume > 0.25) {
                    return "volume_down";
                } else if (device.audio.volume < 0.25) {
                    return "volume_mute";
                }
            }
        }

        "volume_up";
    }

    implicitHeight: icon.height
    implicitWidth: icon.width

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    device: Pipewire.defaultAudioSink

    MaterialIcon {
        id: icon
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        IconMouseArea {
            device: root.device
        }

        font.pixelSize: 20
        color: Theme.blue1

        text: root.icon
    }
}
