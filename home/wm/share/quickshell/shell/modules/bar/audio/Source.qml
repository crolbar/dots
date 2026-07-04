import QtQuick
import Quickshell.Services.Pipewire
import qs.utils

AudioDevice {
    id: root
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSource]
    }
    device: Pipewire.defaultAudioSource

    visible: !root.device.audio.muted
    iconText: "mic"
    iconColor: (root.device.audio.muted) ? Theme.blue1 : Theme.red0
}
