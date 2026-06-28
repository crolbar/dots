pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import qs.utils
import qs.modules.bar
import qs.config

// qmllint disable uncreatable-type
PanelWindow {
    id: root
    property string name: "bar"
    property Config config

    color: (config.selected_tray_item == -1) ? Theme.bg0 : Theme.bg1

    anchors {
        top: true
        left: true
        bottom: true
    }

    implicitWidth: 32

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
            bar.mouseWheelHandle(w);
        }
        onClicked: me => {
            // console.log(me.button == Qt.ForwardButton)
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
        }

        Rectangle {
            visible: root.config.selected_tray_item != -1

            implicitWidth: 1

            height: visible ? root.height : 0

            Behavior on height {
                NumberAnimation {
                    duration: 900
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: [0.1, 0.12, 0.23, 0.29, 0.41, 0.38, 0.59, 0.48, 0.58, 0.79, 1.0, 1.0]
                }
            }

            anchors.right: parent.right
            anchors.bottom: parent.bottom

            color: Theme.yellow0
        }
    }
}
