pragma ComponentBehavior: Bound

import QtQuick.Layouts
import Quickshell.Widgets
import QtQuick.Controls
import Quickshell
import QtQuick
import qs.config
import qs.utils

StackView {
    id: root
    property Config config
    required property QsMenuHandle initialHandle

    initialItem: SubItem {
        handle: root.initialHandle
        isSubItem: false
    }

    pushEnter: NoAnim {}
    pushExit: NoAnim {}
    popEnter: NoAnim {}
    popExit: NoAnim {}
    component NoAnim: Transition {
        NumberAnimation {
            duration: 0
        }
    }

    Component {
        id: subItemComp

        SubItem {}
    }

    onInitialHandleChanged: {
        if (depth > 1)
            pop();
    }

    component SubItem: Column {
        id: subItem
        required property QsMenuHandle handle
        required property bool isSubItem

        spacing: 8

        QsMenuOpener {
            id: menuOpener
            menu: subItem.handle
        }

        Repeater {
            model: menuOpener.children

            Rectangle {
                id: item
                required property QsMenuEntry modelData

                implicitHeight: (modelData && modelData.isSeparator) ? 1 : child.implicitHeight
                implicitWidth: (modelData && modelData.isSeparator) ? subItem.implicitWidth : child.implicitWidth

                color: (modelData && modelData.isSeparator) ? Theme.yellow0 : Theme.bg1

                Loader {
                    id: child
                    active: item.modelData && !item.modelData.isSeparator
                    anchors.fill: parent
                    sourceComponent: Item {
                        implicitHeight: row.implicitHeight
                        implicitWidth: row.implicitWidth

                        MouseArea {
                            id: mouseArea
                            anchors.margins: -4

                            anchors {
                                top: parent.top
                                bottom: parent.bottom
                                left: parent.left
                            }
                            implicitWidth: subItem.implicitWidth + 40

                            enabled: item.modelData && item.modelData.enabled
                            hoverEnabled: true
                            cursorShape: !enabled ? undefined : Qt.PointingHandCursor

                            onClicked: {
                                const entry = item.modelData;
                                if (entry.hasChildren) {
                                    root.push(subItemComp.createObject(null, {
                                        handle: entry,
                                        isSubItem: true
                                    }));
                                    root.config.selected_tray_item_noexit = true;
                                } else {
                                    item.modelData.triggered();
                                    if (subItem.isSubItem) {
                                        root.pop();
                                    }
                                    root.config.selected_tray_item = -1;
                                }
                            }
                            Rectangle {
                                anchors.fill: parent
                                opacity: (mouseArea.containsMouse) ? 1 : 0
                                color: Theme.bg2

                                radius: 10
                            }
                        }

                        RowLayout {
                            id: row
                            spacing: 4

                            Loader {
                                id: icon

                                active: item.modelData && item.modelData.icon !== ""

                                sourceComponent: IconImage {
                                    implicitSize: label.implicitHeight

                                    source: item.modelData.icon
                                }
                            }

                            Text {
                                id: label
                                color: item.modelData && (item.modelData.enabled) ? Theme.fg1 : Theme.fg4

                                text: item.modelData && item.modelData.text
                            }

                            Loader {
                                id: expand
                                active: item.modelData && item.modelData.hasChildren
                                sourceComponent: MaterialIcon {
                                    text: "chevron_right"
                                    color: item.modelData.enabled ? Theme.fg2 : Theme.bg2
                                }
                            }
                        }
                    }
                }
            }
        }

        Loader {
            asynchronous: true
            active: subItem.isSubItem

            sourceComponent: Item {
                implicitWidth: back.implicitWidth
                implicitHeight: back.implicitHeight

                Item {
                    anchors.bottom: parent.bottom
                    implicitWidth: back.implicitWidth
                    implicitHeight: back.implicitHeight

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: -2
                        anchors.rightMargin: -8

                        radius: 10
                        color: Theme.bg2

                        MouseArea {
                            id: backMouseArea

                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: !enabled ? undefined : Qt.PointingHandCursor

                            onClicked: {
                                root.pop();
                                F.delay(100, function () {
                                    root.config.selected_tray_item_noexit = false;
                                });
                            }
                            Rectangle {
                                anchors.fill: parent
                                opacity: (backMouseArea.containsMouse) ? 1 : 0
                                color: Theme.bg3

                                radius: 10
                            }
                        }
                    }

                    Row {
                        id: back

                        anchors.verticalCenter: parent.verticalCenter

                        MaterialIcon {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "chevron_left"
                        }

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Back"
                            color: Theme.fg0
                        }
                    }
                }
            }
        }
    }
}
