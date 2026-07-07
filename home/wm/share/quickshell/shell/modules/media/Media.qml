pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Io
import qs.utils
import qs.modules.dashboard

Loader {
    Component.onCompleted: Brok.start()
    Component.onDestruction: Brok.stop()

    anchors.fill: parent

    active: Brok.players[0] != undefined

    sourceComponent: Item {
        id: root
        property BrokPlayer player: Brok.players[0]

        anchors.fill: parent

        Item {
            id: cover

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: width
            anchors.margins: 30
            anchors.topMargin: 15

            layer.enabled: true
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowOpacity: 0.5
            }

            Image {
                fillMode: Image.PreserveAspectCrop
                anchors.fill: parent
                source: root.player.artUri

                layer.enabled: true
                layer.effect: MultiEffect {
                    maskEnabled: true
                    maskSpreadAtMin: 1
                    maskThresholdMin: 0.5
                    maskSource: mask
                }
            }

            Rectangle {
                id: mask
                layer.enabled: true
                anchors.fill: parent
                radius: width / 5
                visible: false
            }
        }

        Text {
            id: title

            anchors.top: cover.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 16
            horizontalAlignment: Text.AlignHCenter

            text: root.player.title
            color: Theme.fg1
            font.pixelSize: 14
            font.weight: Font.DemiBold

            width: parent.width - 16
            elide: Text.ElideRight
        }

        Text {
            id: artist

            anchors.top: title.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 8
            horizontalAlignment: Text.AlignHCenter

            text: root.player.artist
            color: Theme.fg2
            font.pixelSize: 14

            width: parent.width - 16
            elide: Text.ElideRight
        }

        RowLayout {
            id: controls

            anchors.top: artist.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 16
            anchors.topMargin: 12

            spacing: 8

            Process {
                id: proc
                property string cmd: "play-pause"
                command: ["sh", "-c", `brokctl ${cmd}`]
                running: false
            }

            Button {
                implicitHeight: prevIcon.height
                Layout.fillWidth: true

                radius: 10
                color: (hovered) ? Theme.bg2 : "transparent"
                onClick: () => {
                    proc.cmd = "prev";
                    proc.running = true;
                }
                MaterialIcon {
                    id: prevIcon
                    anchors.centerIn: parent
                    color: Theme.fg2
                    text: "skip_previous"
                    font.pixelSize: 28
                }
            }

            Button {
                implicitHeight: playIcon.height
                Layout.fillWidth: true
                radius: 10
                color: (hovered) ? Theme.aqua1 : Theme.aqua0
                onClick: () => {
                    proc.cmd = "play-pause";
                    proc.running = true;
                }
                MaterialIcon {
                    id: playIcon
                    anchors.centerIn: parent
                    color: Theme.bg1
                    text: (root.player.status) ? "play_arrow" : "pause"
                    font.pixelSize: 32
                    font.weight: Font.DemiBold
                }
            }

            Button {
                implicitHeight: nextIcon.height
                Layout.fillWidth: true
                radius: 10
                color: (hovered) ? Theme.bg2 : "transparent"
                onClick: () => {
                    proc.cmd = "next";
                    proc.running = true;
                }
                MaterialIcon {
                    id: nextIcon
                    anchors.centerIn: parent
                    color: Theme.fg2
                    text: "skip_next"
                    font.pixelSize: 28
                }
            }
        }


        // TODO: add player focus changing
    }
}
