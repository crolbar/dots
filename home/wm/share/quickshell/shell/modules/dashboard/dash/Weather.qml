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
        color: Theme.bg0
        font.pixelSize: 82
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
            // season changing
            color: {
                const m = Time.format("MM");
                switch (parseInt(m)) {
                case 11:
                case 12:
                case 1:
                case 2:
                    return Theme.blue1;
                case 3:
                case 4:
                case 5:
                    return Theme.green1;
                case 6:
                case 7:
                case 8:
                    return Theme.yellow1;
                case 9:
                case 10:
                    return Theme.orange1;
                }
            }
            opacity: 0.7
            font.pixelSize: 32
            font.weight: Font.DemiBold
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter

            text: WeatherData.description
            color: Theme.fg3
            font.pixelSize: 14
            font.weight: 500
        }
    }
}
