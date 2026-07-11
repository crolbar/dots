pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import Quickshell.Io
import qs.utils
import qs.config
import qs.modules.dashboard

Item {
    id: root
    required property Config config
    required property BrokPlayer player
    required property bool isFocused

    implicitWidth: 180

    Process {
        id: proc
        property string cmd: "play-pause"
        command: ["sh", "-c", `brokctl ${cmd}`]
        running: false
    }

    function runBrok(cmd) {
        proc.cmd = cmd;
        proc.running = true;
    }

    Loader {
        id: playerName
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: -4

        active: !root.isFocused
        sourceComponent: Item {
            implicitHeight: name.height
            Text {
                id: name
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.aqua0
                text: root.player.name
                font.pixelSize: 18
                font.bold: true
            }
        }
    }

    MouseArea {
        acceptedButtons: (root.isFocused) ? Qt.RightButton : Qt.LeftButton
        anchors.fill: (root.isFocused) ? parent : cover
        cursorShape: (root.isFocused) ? undefined : Qt.PointingHandCursor
        onClicked: {
            if (root.isFocused) {
                root.config.media_focus_popout_open = !root.config.media_focus_popout_open;
                const topLeftCorner = root.mapToItem(null, 0, 0);
                root.config.media_focus_popout_y = topLeftCorner.y + root.height / 2;
            } else {
                root.runBrok(`focus ${root.player.id}`);
                root.config.media_focus_popout_open = false;

                if (root.config.media_popout_closing_timer)
                    root.config.media_popout_closing_timer.restart();
            }
        }
    }

    Item {
        id: cover

        anchors.top: (root.isFocused) ? parent.top : playerName.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        implicitHeight: width
        anchors.margins: 30
        anchors.topMargin: (root.isFocused) ? 15 : 8

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
        anchors.topMargin: (root.isFocused) ? 16 : 8
        horizontalAlignment: Text.AlignHCenter

        text: root.player.title
        color: Theme.fg1
        font.pixelSize: 14
        font.weight: Font.DemiBold

        HoverHandler {
            id: titleHh
            enabled: title.truncated
        }
        ToolTip {
            visible: titleHh.hovered
            contentItem: Text {
                text: root.player.title
                color: Theme.fg1
            }
            background: Rectangle {
                color: Theme.bg1
                radius: 10
            }

            y: 20
        }

        width: parent.width - 16
        elide: Text.ElideRight
    }

    Text {
        id: artist

        anchors.top: title.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: (root.isFocused) ? 8 : 4
        horizontalAlignment: Text.AlignHCenter

        text: root.player.artist
        color: Theme.fg2
        font.pixelSize: 14

        width: parent.width - 16
        elide: Text.ElideRight
    }

    Loader {
        anchors.top: artist.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16
        anchors.topMargin: 12

        active: root.isFocused
        sourceComponent: RowLayout {
            id: controls

            anchors.fill: parent

            spacing: 8

            Button {
                implicitHeight: prevIcon.height
                Layout.fillWidth: true

                radius: 10
                color: (hovered) ? Theme.bg2 : "transparent"
                onClick: () => {
                    root.runBrok("prev");
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
                    root.runBrok("play-pause");
                }

                layer.enabled: true
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    shadowOpacity: 0.4
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
                    root.runBrok("next");
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
    }
}
