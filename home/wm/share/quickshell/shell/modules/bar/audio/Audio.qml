import qs.utils
import QtQuick.Layouts
import QtQuick

Widget {
    implicitWidth: 32
    implicitHeight: layout.implicitHeight

    color: "transparent"

    ColumnLayout {
        id: layout
        anchors.horizontalCenter: parent.horizontalCenter

        Source {}
        Sink {}
    }
}
