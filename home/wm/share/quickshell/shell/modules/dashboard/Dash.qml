import "dash"
import QtQuick
import QtQuick.Layouts
import qs.utils

GridLayout {
    columns: 5
    rows: 3
    rowSpacing: 8
    columnSpacing: 8

    Rect {
        Layout.row: 0
        Layout.column: 0
        Layout.rowSpan: 2

        Text {
            anchors.centerIn: parent
            color: Theme.fg1
            text: "media"
        }
    }

    Rect {
        Layout.row: 2
        Layout.column: 0
        Layout.maximumHeight: 60

        Text {
            color: Theme.fg1
            text: "Apps"
        }
    }

    Rect {
        Layout.row: 0
        Layout.column: 2
        Layout.rowSpan: 1
        Layout.maximumHeight: 120

        Date {}
    }

    Rect {
        Layout.row: 0
        Layout.column: 3
        Layout.rowSpan: 1
        Layout.maximumHeight: 120

        Weather {}
    }

    Rect {
        Layout.row: 1
        Layout.column: 2
        Layout.columnSpan: 2
        Layout.rowSpan: 2

        Text {
            color: Theme.fg1
            text: "calendar"
        }
    }

    ColumnLayout {
        Layout.row: 0
        Layout.column: 4
        Layout.rowSpan: 3
        Layout.columnSpan: 1
        Layout.maximumWidth: 60

        Rect {
            Text {
                anchors.centerIn: parent
                color: Theme.fg1
                text: "brightness"
            }
        }

        Rect {
            Layout.maximumHeight: 60

            Text {
                anchors.centerIn: parent
                color: Theme.fg1
                text: "power"
            }
        }
    }

    component Rect: Rectangle {
        color: Theme.bg1
        Layout.fillWidth: true
        Layout.fillHeight: true
        radius: 20
    }
}
