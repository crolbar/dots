pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import qs.utils

Item {
    id: root

    anchors.fill: parent

    readonly property string dayStr: Time.format("dd")
    readonly property string mounthStr: Time.format("MM")
    readonly property string yearStr: Time.format("yy")
    readonly property string weekDayStr: Time.format("dddd")

    readonly property string timeStr: Time.format(Time.timeStr)
    readonly property list<string> timeComponents: timeStr.split(":")
    readonly property string hourStr: timeComponents[0] ?? ""
    readonly property string minuteStr: timeComponents[1] ?? ""

    readonly property int fontSize: 26
    readonly property int fontWeight: Font.DemiBold

    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 0

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 4

            DateText {
                text: root.hourStr
                color: Theme.yellow0
            }

            DateText {
                text: ":"
            }

            DateText {
                color: Theme.yellow0
                text: root.minuteStr
            }
        }


        DateText {
            Layout.alignment: Qt.AlignHCenter
            text: root.weekDayStr
            color: Theme.yellow0
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter

            spacing: 2
            DateText {
                color: Theme.orange0
                text: root.dayStr
            }

            DateText {
                text: "."
            }

            DateText {
                color: Theme.orange0
                text: root.mounthStr
            }

            DateText {
                text: "."
            }

            DateText {
                color: Theme.orange0
                text: root.yearStr
            }
        }
    }

    component DateText: Text {
        color: Theme.fg4
        font.pixelSize: root.fontSize
        font.weight: root.fontWeight
    }
}
