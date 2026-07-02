import QtQuick
import Quickshell.Services.Pipewire
import qs.utils

AudioDevice {
    id: root
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSource]
    }
    device: Pipewire.defaultAudioSource

    iconText: (root.device.audio.muted) ? "mic_off" : "mic"
    iconColor: (root.device.audio.muted) ? Theme.blue1 : Theme.red0
}
