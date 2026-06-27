import Quickshell
import QtQuick

PanelWindow {
    id: test
    property string name: "test"

    color: "black"

    Text {
        color: "white"
        anchors.centerIn: parent
        text: "test"
    }
}
