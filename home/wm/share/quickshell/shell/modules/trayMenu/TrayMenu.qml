pragma ComponentBehavior: Bound

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

    required property var cb
    property int currentWidth: currentItem.implicitWidth
    property int currentHeight: currentItem.implicitHeight

    anchors.fill: parent

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

    component SubItem: Column {
        id: subItem
        required property QsMenuHandle handle
        required property bool isSubItem

        padding: 16
        spacing: 8

        // telling when the whole menu is ready for render
        // removes flicker of small window
        Component.onCompleted: () => {
            // Func.delay(30, () => root && root.cb(true));
            const callback = root.cb;
            F.delay(30, () => {
                if (callback)
                    callback(true);
            });
        }
        Component.onDestruction: () => {
            root.cb(false);
        }

        QsMenuOpener {
            id: menuOpener
            menu: subItem.handle
        }

        Repeater {
            model: menuOpener.children

            Rectangle {
                id: item
                required property QsMenuEntry modelData

                implicitHeight: modelData && modelData.isSeparator ? 1 : children.implicitHeight
                implicitWidth: 230
                radius: 10

                color: modelData && modelData.isSeparator ? Theme.yellow0 : Theme.bg1

                Loader {
                    id: children
                    active: item.modelData && !item.modelData.isSeparator

                    anchors.left: parent.left
                    anchors.right: parent.right

                    sourceComponent: Item {
                        implicitHeight: label.implicitHeight

                        MouseArea {
                            id: mouseArea
                            anchors.margins: -2

                            anchors.fill: parent
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

                        Loader {
                            id: icon

                            anchors.left: parent.left

                            active: item.modelData && item.modelData.icon !== ""

                            sourceComponent: IconImage {
                                implicitSize: label.implicitHeight

                                source: item.modelData.icon
                            }
                        }

                        Text {
                            id: label
                            color: item.modelData && (item.modelData.enabled) ? Theme.fg1 : Theme.fg4
                            anchors.left: icon.right
                            anchors.leftMargin: 4

                            text: item.modelData && item.modelData.text
                        }

                        Loader {
                            id: expand

                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right

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
