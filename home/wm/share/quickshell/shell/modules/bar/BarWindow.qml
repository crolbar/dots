import Quickshell
import QtQuick
import qs.utils
import qs.modules.bar
import qs.config

// qmllint disable uncreatable-type
PanelWindow {
    id: root
    property string name: "bar"
    property Config config

    color: Theme.bg0

    anchors {
        top: true
        left: true
        bottom: true
    }

    implicitWidth: 32

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onPositionChanged: me => {
            bar.mouseEventHandle(me.y);
        }

        onWheel: e => {
            console.log(e.angleDelta.y);
        }

        Bar {
            id: bar
            config: root.config
        }
    }
}
