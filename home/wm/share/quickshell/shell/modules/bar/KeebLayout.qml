import qs.utils
import QtQuick

Widget {
    id: root
    required property string layout

    implicitWidth: 32
    implicitHeight: (layout == "English (US)") ? 0 : text.implicitHeight

    color: "transparent"

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 150
        }
    }

    Text {
        id: text
        visible: root.layout != "English (US)"
        anchors.centerIn: parent
        color: Theme.bg3
        text: {
            const i = root.layout.indexOf("(") + 1;
            root.layout.slice(i, i + 2);
        }
    }

    Spacer {
        visible: root.layout != "English (US)"
        anchors.bottom: parent.bottom
    }
}
