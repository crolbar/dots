pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.utils

Item {
    id: root
    implicitHeight: 400
    implicitWidth: 650

    property int padding: 8
    property int focusedTab: 0

    readonly property var dashboardTabs: [
        {
            name: "Dashboard",
            comp: dash
        },
        {
            name: "Performance",
            comp: performance
        },
        {
            name: "Weather",
            comp: weather
        }
    ]

    Item {
        id: tabs
        implicitHeight: 30

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: root.padding

        RowLayout {
            spacing: 8
            anchors.fill: parent

            Repeater {
                model: root.dashboardTabs
                Loader {
                    id: tabButtonLoader
                    required property int index
                    required property var modelData
                    height: tabs.implicitHeight
                    Layout.fillWidth: true
                    sourceComponent: TabButton {
                        tab: tabButtonLoader.modelData.name
                        tabIdx: tabButtonLoader.index
                    }
                }
            }
        }
    }

    component TabButton: Button {
        id: tabButton
        required property string tab
        required property int tabIdx
        onClick: () => {
            root.focusedTab = tabIdx;
        }

        color: (hovered) ? Theme.bg2 : Theme.bg1
        radius: 5
        Text {
            id: text
            anchors.centerIn: parent
            color: Theme.fg0
            text: tabButton.tab
        }
    }

    ClippingRectangle {
        id: view

        anchors.top: tabs.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: root.padding

        radius: 10
        color: Theme.bg0

        Flickable {
            readonly property Item currentItem: repeater.itemAt(root.focusedTab)
            contentX: currentItem?.x || 0

            anchors.fill: parent

            flickableDirection: Flickable.HorizontalFlick

            contentWidth: layout.implicitWidth
            contentHeight: layout.implicitHeight

            Behavior on contentX {
                NumberAnimation {
                    duration: 500

                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: [0.38, 1.21, 0.22, 1, 1, 1]
                }
            }

            RowLayout {
                id: layout

                Repeater {
                    id: repeater
                    model: root.dashboardTabs
                    Loader {
                        Layout.preferredWidth: view.width
                        Layout.preferredHeight: view.height
                        Layout.alignment: Qt.AlignTop
                        required property var modelData
                        sourceComponent: modelData.comp
                    }
                }

                Component {
                    id: dash
                    Dash {}
                }
                Component {
                    id: performance
                    Performance {}
                }
                Component {
                    id: weather
                    Weather {}
                }
            }
        }
    }
}
