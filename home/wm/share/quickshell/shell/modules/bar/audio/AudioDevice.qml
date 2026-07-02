import qs.utils
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire

Rectangle {
    id: root
    required property PwNode device
    required property string iconText
    required property color iconColor
    property int level: (expanded) ? root.device.audio.volume * 100 : 0

    property bool expanded: ma.containsMouse && !anim.running

    Layout.alignment: Qt.AlignCenter
    color: (expanded || anim.running) ? Theme.bg2 : "transparent"

    implicitHeight: iconItem.height
    Layout.preferredWidth: 32
    Layout.preferredHeight: ma.containsMouse ? implicitHeight * 4 : implicitHeight
    Layout.minimumHeight: Layout.preferredHeight
    Layout.maximumHeight: Layout.preferredHeight

    radius: 5

    Behavior on Layout.preferredHeight {
        NumberAnimation {
            id: anim
            duration: 170
        }
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
    }

    Rectangle {
        id: slider
        property int padding: 4
        property int fullExpandedHeight: (root.implicitHeight * 3 - padding * 2)

        visible: root.expanded

        implicitHeight: fullExpandedHeight
        radius: 8

        anchors {
            right: parent.right
            bottom: parent.bottom
            left: parent.left
            bottomMargin: root.implicitHeight

            leftMargin: padding
            rightMargin: padding
        }

        MouseArea {
            property double lastPressY: 0.0
            anchors.fill: parent
            onPressed: me => {
                lastPressY = me.y;
                root.device.audio.volume = (height - me.y) / height;
            }
            onReleased: me => {
                if (me.y != lastPressY)
                    root.device.audio.volume = (height - me.y) / height;
            }
            onWheel: me => root.device.audio.volume = ((Math.floor(root.device.audio.volume * 100) + ((me.angleDelta.y) > 0 ? 5 : -5))) / 100
            cursorShape: Qt.PointingHandCursor
        }

        color: Theme.bg1

        Rectangle {
            anchors {
                right: parent.right
                bottom: parent.bottom
                left: parent.left
            }

            implicitHeight: (root.expanded) ? slider.fullExpandedHeight * root.device.audio.volume : 0

            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 140
                }
            }

            radius: slider.radius
            color: Theme.blue1
        }
    }

    Behavior on level {
        NumberAnimation {
            duration: 340
        }
    }

    Text {
        visible: root.expanded
        anchors.centerIn: parent
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
