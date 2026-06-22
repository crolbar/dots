import Quickshell
import Quickshell.Io
import QtQuick

FloatingWindow {
    id: niri_bar
    property string name: "niri_bar"

    color: "red"

    // the screen from the screens list will be injected into this
    // property
    required property var modelData

    // we can then set the window's screen to the injected property
    screen: modelData

    // visible: false

    // anchors {
    //     top: true
    //     left: true
    //     right: true
    // }

    implicitHeight: 30

    Text {
        id: clock
        color: "white"
        anchors.centerIn: parent
        text: "niri"
    }
}
