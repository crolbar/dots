pragma ComponentBehavior: Bound

import qs.utils
import Quickshell.Services.Pipewire
import QtQuick

Item {
    id: root
    implicitWidth: col.width
    implicitHeight: col.height
    property real vol: Math.floor(node.audio.volume * 100)
    required property PwNode node
    PwObjectTracker {
        objects: [root.node]
    }

    Column {
        id: col
        spacing: 4
        clip: true
        Item {
            implicitWidth: volBar.width
            implicitHeight: nameText.height
            Text {
                id: nameText
                color: Theme.fg0
                width: row.implicitWidth
                text: (root.node.isStream) ? root.node.name : root.node.nickname
            }
            Text {
                anchors.right: parent.right
                color: Theme.bg2
                font.bold: true
                text: {
                    Math.floor(root.node.audio.volume * 100);
                }
            }
        }

        Item {
            id: row
            implicitHeight: 25
            implicitWidth: 250

            Item {
                id: volBar
                anchors.left: row.left
                anchors.right: buttons.left
                implicitHeight: parent.height

                Slider {
                    volume: root.node.audio.volume
                    siliderColor: Theme.aqua0
                    handlePressed: me => {
                        lastPressX = me.x;
                        root.node.audio.volume = me.x / width;
                    }
                    handleReleased: me => {
                        if (me.y != lastPressX)
                            root.node.audio.volume = me.x / width;
                    }
                    handleWheel: me => root.node.audio.volume = ((Math.floor(root.node.audio.volume * 100) + ((me.angleDelta.y) > 0 ? 5 : -5))) / 100
                }
            }

            Item {
                id: buttons
                anchors.right: parent.right
                implicitHeight: parent.height
                implicitWidth: muteIconRect.width + ((!root.node.isStream) ? defaultDevIconRect.width + 16 : 8)

                Loader {
                    id: muteIconRect
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.right: parent.right

                    sourceComponent: Button {
                        val: root.node.audio.muted
                        onClick: () => root.node.audio.muted = !root.node.audio.muted
                        iconColor: (!root.node.audio.muted) ? Theme.fg1 : Theme.red0
                        iconText: {
                            // qmllint disable unresolved-type
                            if (root.node.type == 9)
                                return (!root.node.audio.muted) ? "mic" : "mic_off";
                            return (!root.node.audio.muted) ? "volume_up" : "volume_off";
                        }
                    }
                }

                Loader {
                    id: defaultDevIconRect
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.right: muteIconRect.left
                    anchors.rightMargin: 8
                    active: Pipewire.defaultAudioSink && !root.node.isStream

                    sourceComponent: Button {
                        property string defaultName: (root.node.type == 9 ? Pipewire.defaultAudioSource.name : Pipewire.defaultAudioSink.name)
                        val: defaultName == root.node.name
                        onClick: () => {
                            if (root.node.type == 9)
                                Pipewire.preferredDefaultAudioSource = root.node;
                            else
                                Pipewire.preferredDefaultAudioSink = root.node;
                        }
                        iconColor: (defaultName == root.node.name) ? Theme.aqua0 : Theme.fg1
                        iconText: (defaultName == root.node.name) ? "check_circle" : "x_circle"
                    }
                }
            }
        }
    }
}
