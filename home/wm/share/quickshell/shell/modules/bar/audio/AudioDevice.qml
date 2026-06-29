import qs.utils
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Pipewire

Rectangle {
    id: root
    required property PwNode device
    property int level: (expanded) ? root.device.audio.volume * 100 : 0

    property bool expanded: ma.containsMouse && !anim.running

    Layout.alignment: Qt.AlignCenter
    color: (expanded || anim.running) ? Theme.bg2 : "transparent"

    Layout.preferredWidth: implicitWidth + 8
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
            anchors.fill: parent
            onClicked: me => root.device.audio.volume = (height - me.y) / height
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
}
