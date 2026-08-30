import qs.utils
import qs.config
import QtQuick

Widget {
    id: root
    required property Config config
    name: "pinbutton"
    implicitWidth: 32
    implicitHeight: 1
    color: !root.config.bar_pinned ? Theme.green0 : "transparent"
    opacity: 0.5

    HoverHandler {
        onHoveredChanged: {
            if (hovered) {
                root.config.bar_pinned = !root.config.bar_pinned;
            }
        }
    }
}
