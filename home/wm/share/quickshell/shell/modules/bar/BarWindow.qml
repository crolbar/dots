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

    color: (config.selected_tray_item == -1 ) ? Theme.bg0: Theme.bg1

    anchors {
        top: true
        left: true
        bottom: true
    }

    implicitWidth: 32

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        onPositionChanged: me => bar.mouseEventHandle(me.y)
        onWheel: w => bar.mouseWheelHandle(w)

        Bar {
            id: bar
            config: root.config
        }
    }
}
