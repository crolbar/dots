pragma ComponentBehavior: Bound

import QtQuick
import qs.utils

Item {
    id: root

    anchors.centerIn: parent

    Component.onCompleted: WeatherData.reload()

    property int padding: 8
    implicitHeight: Math.max(icon.implicitHeight, info.implicitHeight) + padding * 2
    implicitWidth: icon.implicitWidth + info.implicitWidth + info.anchors.leftMargin

    MaterialIcon {
        id: icon
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left

        text: WeatherData.icon
        color: Theme.blue0
        font.pixelSize: 72
    }

    Column {
        id: info
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: icon.right
        anchors.leftMargin: root.padding

        spacing: 0

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: WeatherData.temp
            color: Theme.blue0
            font.pixelSize: 32
            font.weight: Font.DemiBold
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            text: WeatherData.description
            color: Theme.fg2
            font.pixelSize: 14
        }
    }
}
