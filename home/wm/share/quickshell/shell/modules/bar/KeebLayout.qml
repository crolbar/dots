import qs.utils
import QtQuick

Widget {
    id: root
    required property string layout

    visible: (layout != "English (US)")
    implicitWidth: 32
    implicitHeight: (layout == "English (US)") ? 0 : text.implicitHeight + 8

    color: "transparent"

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 150
        }
    }

    Text {
        id: text
        visible: root.layout != "English (US)"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.bottom: spacer.top
        anchors.bottomMargin: 8
        color: Theme.bg3
        text: {
            const i = root.layout.indexOf("(") + 1;
            root.layout.slice(i, i + 2);
        }
    }

    Spacer {
        id: spacer
        visible: root.layout != "English (US)"
        anchors.top: parent.bottom
    }
}
