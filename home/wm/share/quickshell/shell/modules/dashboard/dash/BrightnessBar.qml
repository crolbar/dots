import QtQuick
import qs.utils

Item {
    id: root
    anchors.fill: parent
    anchors.leftMargin: 10
    anchors.rightMargin: 10

    property real brightness: BrightnessData.value

    Item {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: slider.top

        MaterialIcon {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 38
            color: Theme.yellow0
            text: "brightness_medium"
        }
    }

    Rectangle {
        id: slider
        anchors.fill: parent
        anchors.topMargin: 46
        radius: 16
        color: Theme.bg1

        MouseArea {
            anchors.fill: parent
            onClicked: me => {
                const newVal = 1 - (me.y / slider.height);
                BrightnessData.set(newVal);
            }
            onWheel: me => {
                const newVal = root.brightness + ((me.angleDelta.y > 0) ? 1 : -1) * 0.01;
                BrightnessData.set(newVal);
            }
            cursorShape: Qt.PointingHandCursor
        }

        Rectangle {
            id: sliderNob
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            implicitHeight: parent.height * root.brightness

            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 100
                }
            }

            radius: 16
            color: Theme.bg3

            Text {
                anchors.top: parent.top
                anchors.topMargin: 16
                anchors.horizontalCenter: parent.horizontalCenter
                text: Math.round(root.brightness * 100)
                color: Theme.bg1
                font.pixelSize: 16
                font.weight: Font.DemiBold
            }
        }
    }
}
