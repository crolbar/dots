pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Shapes

Rectangle {
    id: a
    required property int w
    required property int h

    visible: w > 0 && h > 0

    // top-right, bottom-right, bottom-left, top-left
    enum Side {
        TopRight = 0,
        BottomRight = 1,
        BottomLeft = 2,
        TopLeft = 3
    }
    required property int side

    required property color arcColor
    required property color fillColor

    implicitHeight: h
    implicitWidth: w

    // start point
    property int sx: (side == 0 || side == 1) ? 0 : w
    property int sy: (side == 1 || side == 2) ? h : 0

    // end point
    property int ex: (side == 0 || side == 1) ? w : 0
    property int ey: (side == 1 || side == 2) ? 0 : h

    //  angle point. where is the right angle
    property int ax: (side == 0 || side == 1) ? w : 0
    property int ay: (side == 1 || side == 2) ? h : 0

    color: "transparent"

    Shape {
        // path is from:
        // angle point
        // start point
        // end point
        // angle point
        ShapePath {
            startX: a.ax
            startY: a.ay

            strokeColor: a.fillColor
            strokeWidth: 1
            fillColor: a.fillColor

            PathLine {
                x: a.sx
                y: a.sy
            }

            ArcPathing {}

            PathLine {
                x: a.ax
                y: a.ay
            }
        }

        // from start to end
        ShapePath {
            startX: a.sx
            startY: a.sy

            strokeColor: a.arcColor
            strokeWidth: 1
            fillColor: "transparent"

            ArcPathing {}
        }
    }
    component ArcPathing: PathArc {
        x: a.ex
        y: a.ey

        radiusX: a.w
        radiusY: a.h

        direction: (a.side == 1 || a.side == 3) ? PathArc.Counterclockwise : PathArc.Clockwise
    }
}
