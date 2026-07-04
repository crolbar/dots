pragma ComponentBehavior: Bound

import qs.utils
import qs.config
import Quickshell.Services.Pipewire
import QtQuick

PopoutWindow {
    id: root
    required property Config config
    side: PopoutWindow.Side.Left
    anchors.bottom: true

    // qmllint disable missing-property unresolved-type unqualified
    margins {
        bottom: Math.max(config.bar_popout_audio_ctl_center_y - (root.implicitHeight / 2), 0)
        left: 31
    }
    expanded: config.bar_popout_audio_ctl_open

    bgColor: Theme.bg0
    borderColor: Theme.bg0

    animationDuration: 150

    MouseArea {
        anchors.fill: parent
        z: -1
        acceptedButtons: Qt.RightButton
        onClicked: root.config.bar_popout_audio_ctl_open = false
    }

    comp: Item {
        id: i
        property int padding: 32
        implicitHeight: loader.height + padding
        implicitWidth: loader.width + padding
        x: i.padding / 2
        y: i.padding / 2

        Loader {
            id: loader
            active: Pipewire.ready

            sourceComponent: Column {
                id: layout

                spacing: 8

                NamedSeparator {
                    name: "Streams"
                    Text {
                        text: Pipewire.defaultAudioSink.nickname
                        anchors.right: parent.right
                        color: Theme.bg2
                    }
                }

                Repeater {
                    model: Pipewire.nodes

                    Loader {
                        id: node
                        required property PwNode modelData
                        // qmllint disable unresolved-type
                        active: modelData && modelData.isStream && modelData.type == 21

                        sourceComponent: Node {
                            node: node.modelData
                        }
                    }
                }

                NamedSeparator {
                    name: "Sinks"
                }

                Repeater {
                    model: Pipewire.nodes
                    Loader {
                        id: node2
                        required property PwNode modelData
                        // qmllint disable unresolved-type
                        active: modelData && modelData.isSink && modelData.type == 17

                        sourceComponent: Node {
                            node: node2.modelData
                        }
                    }
                }

                NamedSeparator {
                    name: "Sources"
                }

                Repeater {
                    model: Pipewire.nodes
                    Loader {
                        id: node3
                        required property PwNode modelData
                        // qmllint disable unresolved-type
                        active: modelData && modelData.type == 9

                        sourceComponent: Node {
                            node: node3.modelData
                        }
                    }
                }
            }
        }
    }
    component NamedSeparator: Item {
        id: sep
        required property string name
        implicitWidth: layout.width
        implicitHeight: 20

        Text {
            text: sep.name
            color: Theme.bg2
        }

        Rectangle {
            implicitWidth: layout.width
            implicitHeight: 1
            anchors.bottom: parent.bottom
            color: Theme.gray
        }
    }
}
