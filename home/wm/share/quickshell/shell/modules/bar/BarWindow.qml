pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Effects
import qs.utils
import qs.modules.bar
import qs.config

// qmllint disable uncreatable-type
PanelWindow {
    id: root
    property string name: "bar"
    required property Config config
    required property var niri

    anchors {
        top: true
        left: true
        bottom: true
    }

    implicitWidth: 32
    onHeightChanged: {
        config.bar_height = height;
    }

    color: "transparent"

    Rectangle {
        id: barRect
        anchors.fill: parent

        color: (root.config.selected_tray_item == -1) ? Theme.bg0 : Theme.bg1

        Behavior on color {
            ColorAnimation {
                duration: 150
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            property bool hWheelScrollDir: false

            acceptedButtons: Qt.AllButtons
            onPositionChanged: me => bar.mouseEventHandle(me.y)
            onWheel: w => {
                if (hWheelScrollDir) {
                    move_focus.dir = (w.angleDelta.y > 0) ? "left" : "right";
                    move_focus.running = true;
                    return;
                }
                workspace_wheel.dir = (w.angleDelta.y > 0) ? "up" : "down";
                workspace_wheel.running = true;
            }
            onClicked: me => {
                if (me.button == Qt.RightButton) {
                    overlay_toggle.running = true;
                } else if (me.button == Qt.LeftButton) {
                    max_toggle.running = true;
                } else if (me.button == Qt.BackButton) {
                    hWheelScrollDir = true;
                } else if (me.button == Qt.ForwardButton) {
                    hWheelScrollDir = false;
                }
            }

            Process {
                id: workspace_wheel
                property string dir
                running: false
                command: {
                    ["sh", "-c", `~/scripts/niri_workspace_scroll.sh ${dir}`];
                }
            }
            Process {
                id: move_focus
                property string dir
                running: false
                command: {
                    ["sh", "-c", `niri msg action focus-column-` + dir];
                }
            }
            Process {
                id: max_toggle
                running: false
                command: {
                    ["sh", "-c", `niri msg action maximize-window-to-edges`];
                }
            }
            Process {
                id: overlay_toggle
                running: false
                command: {
                    ["sh", "-c", `niri msg action toggle-overview`];
                }
            }

            Bar {
                id: bar
                config: root.config
                niri: root.niri
            }

            // Border on popout
            PanelWindow {
                id: shadowWindow
                exclusionMode: ExclusionMode.Ignore
                implicitWidth: 30

                anchors {
                    top: true
                    left: true
                    bottom: true
                }
                color: "transparent"

                margins.left: root.implicitWidth

                visible: root.config.bar_popout_border_visible

                MultiEffect {
                    anchors.fill: shadowRect
                    source: shadowRect
                    shadowEnabled: true
                    shadowHorizontalOffset: 2
                    shadowScale: 4
                }
                Rectangle {
                    id: shadowRect
                    anchors.bottom: parent.bottom
                    implicitWidth: 1

                    property bool expand: root.config.bar_popout_audio_ctl_open || root.config.selected_tray_item != -1

                    height: expand ? root.height : 0
                    Behavior on height {
                        NumberAnimation {
                            id: anim
                            duration: 300
                            easing.type: Easing.BezierSpline
                            easing.bezierCurve: [0.1, 0.12, 0.23, 0.29, 0.41, 0.38, 0.59, 0.48, 0.58, 0.79, 1.0, 1.0]
                        }
                    }

                    color: (root.config.bar_popout_border_visible_for == "audio") ? Theme.bg0 : Theme.yellow0
                }
            }
        }
    }
}
