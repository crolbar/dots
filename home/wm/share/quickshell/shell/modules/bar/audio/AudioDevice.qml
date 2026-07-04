import qs.utils
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import qs.config

Item {
    id: root
    required property PwNode device
    required property string iconText
    required property color iconColor
    required property Config config
    property int level: root.device.audio.volume * 100
    property bool levelVisible: false

    implicitHeight: iconItem.height
    Layout.preferredWidth: 32
    Layout.minimumHeight: Layout.preferredHeight
    Layout.maximumHeight: Layout.preferredHeight

    NumberAnimation {
        id: showLevelAnim
        target: root
        property: "implicitHeight"
        to: iconItem.height + levelText.height * 2
        duration: 850
        easing.type: Easing.OutQuad
    }
    NumberAnimation {
        id: hideLevelAnim
        target: root
        property: "implicitHeight"
        to: iconItem.height
        duration: 450
        easing.type: Easing.InQuad
        onFinished: {
            root.levelVisible = false;
        }
    }
    onLevelChanged: {
        showLevelAnim.start();
        levelVisible = true;
        if (timer.running) {
            timer.restart();
        } else {
            timer.running = true;
        }
    }

    Timer {
        id: timer
        interval: 1000
        onTriggered: {
            hideLevelAnim.start();
        }
    }

    Text {
        id: levelText
        anchors.centerIn: parent
        anchors.top: parent.top
        visible: root.levelVisible
        font.pixelSize: 14
        font.bold: true
        color: Theme.blue0
        text: root.level
    }

    Item {
        id: iconItem
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        implicitHeight: icon.height + 12

        IconMouseArea {
            device: root.device
            config: root.config
        }
        MaterialIcon {
            id: icon
            anchors.centerIn: parent

            font.pixelSize: 20

            Behavior on color {
                ColorAnimation {
                    duration: 250
                }
            }

            color: root.iconColor

            text: root.iconText
        }
    }
}
