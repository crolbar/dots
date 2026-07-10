pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.utils

MouseArea {
    id: root

    property date now: new Date()

    property var selectedDate: ({
            curr: now,
            prev: now
        })

    readonly property int animDirection: selectedDate.prev > selectedDate.curr ? -1 : 1
    readonly property int selectedMonth: selectedDate.curr.getMonth()
    readonly property int selectedYear: selectedDate.curr.getFullYear()
    readonly property int currentMonth: now.getMonth()
    readonly property int currentYear: now.getFullYear()

    property real animTranslate
    property real animOpacity: 1

    onWheel: event => {
        if (event.angleDelta.y > 0) {
            const prevSelectedDate = root.selectedDate.curr;
            selectedDate = ({
                    prev: prevSelectedDate,
                    curr: new Date(selectedYear, selectedMonth - 1, 1)
                });
        } else if (event.angleDelta.y < 0) {
            const prevSelectedDate = root.selectedDate.curr;
            selectedDate = ({
                    prev: prevSelectedDate,
                    curr: new Date(selectedYear, selectedMonth + 1, 1)
                });
        }
    }

    anchors.left: parent.left
    anchors.right: parent.right
    implicitHeight: inner.implicitHeight + inner.anchors.margins * 2

    acceptedButtons: Qt.MiddleButton
    onClicked: root.selectedDate = new Date()

    NumberAnimation {
        id: trOutAnim
        running: false
        target: root
        property: "animTranslate"
        to: 32 * root.animDirection
    }

    property date selDate: selectedDate.curr
    Behavior on selDate {
        SequentialAnimation {
            ParallelAnimation {
                ScriptAction {
                    script: Qt.callLater(() => trOutAnim.start())
                }
                NumberAnimation {
                    target: root
                    property: "animOpacity"
                    to: 0
                }
            }
            ScriptAction {
                script: {
                    trOutAnim.complete();
                    root.animTranslate = 32 * -root.animDirection;
                }
            }
            PropertyAction {}
            ParallelAnimation {
                NumberAnimation {
                    target: root
                    property: "animTranslate"
                    duration: 50
                    to: 0
                }
                NumberAnimation {
                    target: root
                    property: "animOpacity"
                    duration: 50
                    to: 1
                }
            }
        }
    }

    ColumnLayout {
        id: inner

        anchors.fill: parent
        anchors.margins: 8
        spacing: 2

        RowLayout {
            id: monthNavigationRow

            Layout.fillWidth: true

            Rectangle {
                implicitHeight: implicitWidth
                implicitWidth: iconLeft.implicitHeight
                color: (maLeft.containsMouse) ? Theme.bg2 : Theme.bg1
                radius: 10
                MouseArea {
                    id: maLeft
                    hoverEnabled: true
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: me => {
                        const prevSelectedDate = root.selectedDate.curr;
                        root.selectedDate = ({
                                prev: prevSelectedDate,
                                curr: new Date(root.selectedYear, root.selectedMonth - 1, 1)
                            });
                    }
                }

                MaterialIcon {
                    id: iconLeft
                    anchors.centerIn: parent
                    text: "chevron_left"
                    font.pixelSize: 24
                    font.bold: true
                }
            }

            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                implicitWidth: monthYearDisplay.implicitWidth + 8 * 2
                implicitHeight: monthYearDisplay.implicitHeight + 2 * 2

                Rectangle {
                    anchors.fill: parent
                    color: (ma.containsMouse) ? Theme.bg2 : Theme.bg1
                    radius: 10
                    MouseArea {
                        id: ma
                        hoverEnabled: true
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: me => {
                            const prevSelectedDate = root.selectedDate.curr;
                            root.selectedDate = ({
                                    prev: prevSelectedDate,
                                    curr: new Date()
                                });
                        }
                    }
                    visible: {
                        const now = new Date();
                        return root.selectedMonth !== now.getMonth() || root.selectedYear !== now.getFullYear();
                    }
                }

                Text {
                    id: monthYearDisplay

                    opacity: root.animOpacity
                    transform: Translate {
                        x: root.animTranslate
                    }

                    anchors.centerIn: parent
                    text: grid.title
                    color: Theme.fg2
                    font.pixelSize: 18
                    font.weight: 500
                }
            }

            Rectangle {
                implicitHeight: implicitWidth
                implicitWidth: iconRight.implicitHeight
                color: (maRight.containsMouse) ? Theme.bg2 : Theme.bg1
                radius: 10
                MouseArea {
                    id: maRight
                    hoverEnabled: true
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: me => {
                        const prevSelectedDate = root.selectedDate.curr;
                        root.selectedDate = ({
                                prev: prevSelectedDate,
                                curr: new Date(root.selectedYear, root.selectedMonth + 1, 1)
                            });
                    }
                }

                MaterialIcon {
                    id: iconRight
                    anchors.centerIn: parent
                    text: "chevron_right"
                    font.pixelSize: 24
                    font.bold: true
                }
            }
        }

        DayOfWeekRow {
            id: daysRow

            Layout.fillWidth: true
            locale: grid.locale

            delegate: Text {
                required property var model

                horizontalAlignment: Text.AlignHCenter
                text: model.shortName
                font.pixelSize: 16
                font.weight: Font.Medium
                color: Theme.fg1
            }
        }

        Item {
            Layout.fillWidth: true
            implicitHeight: grid.implicitHeight

            opacity: root.animOpacity
            transform: Translate {
                x: root.animTranslate
            }

            MonthGrid {
                id: grid

                month: root.selectedMonth
                year: root.selectedYear

                anchors.fill: parent

                spacing: 1
                locale: Qt.locale()

                delegate: Item {
                    id: dayItem

                    required property var model

                    implicitWidth: implicitHeight
                    implicitHeight: text.implicitHeight

                    Text {
                        id: text

                        anchors.centerIn: parent

                        horizontalAlignment: Text.AlignHCenter
                        text: grid.locale.toString(dayItem.model.day)
                        color: Theme.fg2
                        opacity: dayItem.model.today || dayItem.model.month === grid.month ? 1 : 0.3
                        font.pixelSize: 16
                    }
                }
            }

            Rectangle {
                readonly property Item todayItem: grid.contentItem.children.find(c => c.model.today) ?? null

                visible: todayItem

                implicitHeight: implicitWidth
                implicitWidth: todayItem?.implicitHeight + 4 ?? 0

                x: todayItem ? todayItem.x + (todayItem.width - implicitWidth) / 2 : 0
                y: todayItem ? todayItem.y - 2 : 0
                z: -1

                radius: 8
                opacity: 0.8
                color: Theme.purple0

                Behavior on x {
                    NumberAnimation {
                        duration: 120
                    }
                }

                Behavior on y {
                    NumberAnimation {
                        duration: 120
                    }
                }
            }
        }
    }
}
