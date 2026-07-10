pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import qs.utils
import qs.config

Item {
    id: root
    required property Config config

    implicitHeight: 400
    implicitWidth: 650

    property int padding: 8
    property int focused_tab: 0
    Component.onCompleted: {
        focused_tab = Qt.binding(() => config.dashboard_focused_tab);
    }

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
            id: flickable
            readonly property Item currentItem: repeater.itemAt(root.focused_tab)
            contentX: currentItem?.x || 0

            anchors.fill: parent

            flickableDirection: Flickable.HorizontalFlick

            acceptedButtons: Qt.NoButton

            contentWidth: layout.implicitWidth
            contentHeight: layout.implicitHeight

            Behavior on contentX {
                NumberAnimation {
                    duration: 100

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
                        id: loader
                        required property var modelData
                        required property int index

                        Layout.preferredWidth: view.width
                        Layout.preferredHeight: view.height
                        Layout.alignment: Qt.AlignTop

                        active: root.config.dashboard_focused_tab == index

                        sourceComponent: modelData.comp
                    }
                }

                Component {
                    id: dash
                    Dash {
                        config: root.config
                    }
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

    component TabButton: Button {
        id: tabButton
        required property string tab
        required property int tabIdx
        onClick: () => {
            root.config.dashboard_focused_tab = tabIdx;
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
}
