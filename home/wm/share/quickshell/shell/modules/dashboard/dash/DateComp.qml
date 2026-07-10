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

    readonly property int fontSize: 32
    readonly property int fontWeight: 550

    ColumnLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: 8

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: 4

            DateText {
                text: root.hourStr
                color: Theme.fg1
            }

            DateText {
                text: ":"
            }

            DateText {
                color: Theme.fg1
                text: root.minuteStr
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter

            spacing: 2
            DateText {
                text: root.dayStr
            }

            DateText {
                text: "."
            }

            DateText {
                text: root.mounthStr
            }

            DateText {
                text: "."
            }

            DateText {
                text: root.yearStr
            }
        }
    }

    component DateText: Text {
        color: Theme.fg2
        font.pixelSize: root.fontSize
        font.weight: root.fontWeight
    }
}
