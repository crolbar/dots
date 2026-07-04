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

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }
    device: Pipewire.defaultAudioSink

    iconText: icon
    iconColor: (root.device.audio.muted) ? Theme.yellow0 : Theme.blue0
}
