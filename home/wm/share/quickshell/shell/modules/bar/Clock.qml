pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.utils

Widget {
    id: root

    readonly property int padding: 2

    readonly property string timeStr: Time.format(Time.timeStr)
    readonly property list<string> timeComponents: timeStr.split(":")
    readonly property string hourStr: timeComponents[0] ?? ""
    readonly property string minuteStr: timeComponents[1] ?? ""
    readonly property string amPmStr: timeComponents[2] ?? ""

    implicitWidth: 32
    implicitHeight: layout.implicitHeight + root.padding * 2

    color: "transparent"

    ColumnLayout {
        id: layout

        anchors.centerIn: parent
        spacing: 2

        CText {
            Layout.alignment: Qt.AlignHCenter
            text: root.hourStr
            font: {
                const scale = Math.min(1.05, Math.max(hourMetrics.width, minMetrics.width) / hourMetrics.width);
                Qt.font({
                    letterSpacing: scale,
                    pixelSize: scale * 15
                })
            }

            color: Theme.green1

            TextMetrics {
                id: hourMetrics

                font.family: "Hack"
                text: root.hourStr
            }
        }

        CText {
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: -parent.spacing - 4
            font: {
                const scale = Math.min(1.05, Math.max(hourMetrics.width, minMetrics.width) / hourMetrics.width);
                Qt.font({
                    letterSpacing: scale,
                    pixelSize: scale * 15
                })
            }

            text: root.minuteStr
            color: Theme.green1

            TextMetrics {
                id: minMetrics

                font.family: "Hack"
                text: root.minuteStr
            }
        }
    }
}
