pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Shapes
import qs.utils

Item {
    id: root

    // 0 - 1
    property real value
    property int startAngle: -90
    property int sweepAngle: 360
    property int strokeWidth: 2
    property int padding: 0
    property int spacing: 2
    property color fgColour: Theme.fg1
    property color bgColour: Theme.bg0

    readonly property real size: Math.min(width, height)
    readonly property real arcRadius: (size - padding - strokeWidth) / 2

    property real angle: sweepAngle * root.value

    Behavior on angle {
        NumberAnimation {}
    }

    property real implicitSize

    implicitWidth: implicitSize
    implicitHeight: implicitSize

    Shape {
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            fillColor: "transparent"
            strokeColor: root.bgColour
            strokeWidth: root.strokeWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                id: remainingArc

                radiusX: root.arcRadius
                radiusY: root.arcRadius
                centerX: root.size / 2
                centerY: root.size / 2
                startAngle: root.startAngle
                sweepAngle: root.sweepAngle
            }
        }
    }

    Shape {
        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            fillColor: "transparent"
            strokeColor: root.fgColour
            strokeWidth: root.strokeWidth
            capStyle: ShapePath.RoundCap

            PathAngleArc {
                radiusX: root.arcRadius
                radiusY: root.arcRadius
                centerX: root.size / 2
                centerY: root.size / 2
                startAngle: root.startAngle
                sweepAngle: root.angle
            }
        }
    }
}
