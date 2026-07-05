import QtQuick
import qs.utils
import qs.config

PopoutWindow {
    id: root
    required property Config config

    side: PopoutWindow.Side.Top


    bgColor: Theme.bg0

    animationDuration: 200

    comp: Rectangle {
        implicitHeight: 150
        implicitWidth: 250
        color: Theme.bg0
        Text {
            color: Theme.fg1
            text: "dash"
        }
    }
}
