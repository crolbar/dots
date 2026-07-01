pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Effects
import qs.utils
import QtQuick.Shapes

/* TODO:

- [x] shadow on arcs
- [x] fix arcs breaking (make border out of shape that connect to arc?)
arcs working for all sides

*/

// qmllint disable uncreatable-type
PanelWindow {
    id: root
    // fully expanded dimentions
    required property int w
    required property int h
    // side from which the window should popout
    enum Side {
        Top,
        Left,
        Bottom,
        Right
    }
    required property int side

    required property Component comp

    property bool expanded: true

    property bool shadowEnabled: false
    property string shadowColor: "black"
    property int shadowSpace: 60

    property int arcHeight: 40
    property int arcWidth: 40

    property color bgColor: "#232323"

    // visible: expanded

    implicitHeight: {
        const ss = (shadowEnabled) ? ((side == PopoutWindow.Side.Top || side == PopoutWindow.Side.Bottom) ? shadowSpace / 2 : shadowSpace) : 0;
        // TODO: add arcHeight
        return h + ss;
    }
    implicitWidth: {
        const ss = (shadowEnabled) ? ((side == PopoutWindow.Side.Left || side == PopoutWindow.Side.Right) ? shadowSpace / 2 : shadowSpace) : 0;
        return w + (arcWidth * 4) + ss;
    }

    exclusionMode: ExclusionMode.Ignore

    // color: "black"
    color: "transparent"

    anchors {
        top: (side == PopoutWindow.Side.Top || anchors.top) ? true : false
        right: (side == PopoutWindow.Side.Right || anchors.right) ? true : false
        bottom: (side == PopoutWindow.Side.Bottom || anchors.bottom) ? true : false
        left: (side == PopoutWindow.Side.Left || anchors.left) ? true : false
    }

    property int arcActualHeight: (contents.height < root.arcHeight * 2) ? contents.height / 2 : root.arcHeight
    property int arcActualWidth: (contents.width > root.arcWidth) ? root.arcWidth : contents.width
    property int arcMargin: shadowSpace / 2

    // border
    Arc {
        id: arc1
        anchors.right: arc3.left
        anchors.top: contents.top
        h: root.arcActualHeight
        w: root.arcActualWidth

        side: Arc.Side.TopRight

        arcColor: Theme.orange0
        fillColor: root.bgColor
    }
    Arc {
        id: arc2
        anchors.left: arc4.right
        anchors.top: contents.top
        h: root.arcActualHeight
        w: root.arcActualWidth

        side: Arc.Side.TopLeft

        arcColor: Theme.orange0
        fillColor: root.bgColor
    }
    Arc {
        id: arc3
        anchors.right: contents.left
        anchors.bottom: contents.bottom
        h: root.arcActualHeight
        w: root.arcActualWidth

        side: Arc.Side.BottomLeft

        arcColor: Theme.orange0
        fillColor: "transparent"
        fillColor2: root.bgColor
    }
    Arc {
        id: arc4
        anchors.left: contents.right
        anchors.bottom: contents.bottom
        h: root.arcActualHeight
        w: root.arcActualWidth

        side: Arc.Side.BottomRight

        arcColor: Theme.orange0
        fillColor: "transparent"
        fillColor2: root.bgColor
    }
    LineLink {
        z: 1
        sx: arc3.x
        sy: {
            // small fixup to cover the ends of arcs
            const fixup = ((root.arcHeight * 2 < contents.height) ? 4 : 0);
            return (arc1.y + arc1.height) - fixup;
        }
        ex: arc3.x
        ey: arc3.y
        lineColor: Theme.orange0
    }
    LineLink {
        z: 1
        sx: arc4.x + arc4.width
        sy: {
            const fixup = ((root.arcHeight * 2 < contents.height) ? 4 : 0);
            return (arc2.y + arc2.height) - fixup;
        }
        ex: arc4.x + arc4.width
        ey: arc4.y
        lineColor: Theme.orange0
    }
    LineLink {
        visible: contents.height > 0
        z: 1
        sx: arc3.x + arc3.width
        sy: arc3.y + arc3.height
        ex: arc4.x
        ey: arc4.y + arc4.height
        lineColor: Theme.orange0
    }
    Rectangle {
        id: fillerRect1
        color: root.bgColor
        anchors {
            left: arc1.right
            right: contents.left
            top: contents.top
            bottom: arc3.top
        }
    }
    Rectangle {
        id: fillerRect2
        color: root.bgColor
        anchors {
            right: arc2.left
            left: contents.right
            top: contents.top
            bottom: arc4.top
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: () => {
            root.expanded = true;
        }
        onExited: () => {
            root.expanded = false;
        }
    }

    Shadow {
        anchors.fill: contents
        source: contents
    }
    Shadow {
        anchors.fill: fillerRect1
        source: fillerRect1
    }
    Shadow {
        anchors.fill: fillerRect2
        source: fillerRect2
    }
    Shadow {
        anchors.fill: arc1
        source: arc1
    }
    Shadow {
        anchors.fill: arc2
        source: arc2
    }
    Shadow {
        anchors.fill: arc3
        source: arc3
    }
    Shadow {
        anchors.fill: arc4
        source: arc4
    }

    Rectangle {
        id: contents
        visible: height > 0
        implicitWidth: root.w
        implicitHeight: root.h

        anchors.horizontalCenter: parent.horizontalCenter
        color: root.bgColor

        onHeightChanged: {
            console.log(height, width);
        }

        Loader {
            anchors.fill: parent
            sourceComponent: root.comp
        }

        height: {
            if (root.side != PopoutWindow.Side.Top && root.side != PopoutWindow.Side.Bottom)
                return implicitHeight;
            return (root.expanded) ? implicitHeight : 0;
        }
        width: {
            if (root.side != PopoutWindow.Side.Left && root.side != PopoutWindow.Side.Right)
                return implicitWidth;
            return (root.expanded) ? implicitWidth : 0;
        }

        Behavior on height {
            NumberAnimation {
                duration: 1000
            }
        }
        Behavior on width {
            NumberAnimation {
                duration: 2000
            }
        }
    }

    component Shadow: MultiEffect {
        shadowColor: root.shadowColor
        shadowEnabled: root.shadowEnabled
        z: -1
    }

    component LineLink: Shape {
        id: ll
        property int sx
        property int sy
        property int ex
        property int ey
        property color lineColor
        ShapePath {
            startX: ll.sx
            startY: ll.sy
            strokeColor: ll.lineColor
            PathLine {
                x: ll.ex
                y: ll.ey
            }
        }
    }
}
