pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Effects
import qs.utils
import QtQuick.Shapes

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

    property int arcHeight: 30
    property int arcWidth: 30

    property color bgColor: "#232323"

    property real animationDuration: 250

    // visible: expanded

    implicitHeight: {
        const ss = (shadowEnabled) ? ((F.isVert(side)) ? shadowSpace / 2 : shadowSpace) : 0;
        const as = (F.isHori(side)) ? arcHeight * 2 : 0;
        return h + as + ss;
    }
    implicitWidth: {
        const ss = (shadowEnabled) ? ((F.isHori(side)) ? shadowSpace / 2 : shadowSpace) : 0;
        const as = (F.isVert(side)) ? arcWidth * 4 : 0;
        return w + as + ss;
    }

    exclusionMode: ExclusionMode.Ignore

    color: "transparent"

    anchors {
        top: (F.isTop(side) || anchors.top) ? true : false
        right: (F.isRight(side) || anchors.right) ? true : false
        bottom: (F.isBottom(side) || anchors.bottom) ? true : false
        left: (F.isLeft(side) || anchors.left) ? true : false
    }

    property int arcActualHeight: (contents.height < root.arcHeight * 2) ? contents.height / 2 : root.arcHeight
    property int arcActualWidth: (contents.width > root.arcWidth * 2) ? root.arcWidth : contents.width / 2
    property int arcMargin: shadowSpace / 2

    // border
    Arc {
        id: arc1
        anchors.right: {
            if (F.isVert(root.side)) {
                return arc3.left;
            } else if (F.isRight(root.side)) {
                return contents.right;
            }
            return undefined;
        }
        anchors.top: F.isTop(root.side) ? contents.top : undefined
        anchors.bottom: {
            if (F.isBottom(root.side)) {
                return contents.bottom;
            } else if (F.isLeft(root.side)) {
                return arc3.top;
            }
            return undefined;
        }

        h: root.arcActualHeight
        w: root.arcActualWidth
        z: 1

        side: {
            switch (root.side) {
            case PopoutWindow.Side.Top:
                return Arc.Side.TopRight;
            case PopoutWindow.Side.Bottom:
                return Arc.Side.BottomRight;
            case PopoutWindow.Side.Left:
                return Arc.Side.BottomLeft;
            case PopoutWindow.Side.Right:
                return Arc.Side.BottomRight;
            }
        }

        arcColor: Theme.orange0
        fillColor: root.bgColor
    }
    Arc {
        id: arc2

        anchors.left: F.isVert(root.side) ? arc4.right : undefined
        anchors.right: F.isRight(root.side) ? contents.right : undefined
        anchors.top: {
            if (F.isTop(root.side)) {
                return contents.top;
            } else if (F.isLeft(root.side)) {
                return arc4.bottom;
            } else if (F.isRight(root.side)) {
                return arc4.bottom;
            }
            return undefined;
        }
        anchors.bottom: F.isBottom(root.side) ? contents.bottom : undefined

        h: root.arcActualHeight
        w: root.arcActualWidth
        z: 1

        side: {
            switch (root.side) {
            case PopoutWindow.Side.Top:
                return Arc.Side.TopLeft;
            case PopoutWindow.Side.Bottom:
                return Arc.Side.BottomLeft;
            case PopoutWindow.Side.Left:
                return Arc.Side.TopLeft;
            case PopoutWindow.Side.Right:
                return Arc.Side.TopRight;
            }
        }

        arcColor: Theme.orange0
        fillColor: root.bgColor
    }
    Arc {
        id: arc3

        anchors.right: {
            if (F.isVert(root.side)) {
                return contents.left;
            } else if (F.isLeft(root.side)) {
                return contents.right;
            }
            return undefined;
        }
        anchors.left: (F.isRight(root.side)) ? contents.left : undefined
        anchors.bottom: {
            if (F.isTop(root.side)) {
                return contents.bottom;
            } else if (F.isHori(root.side)) {
                return contents.top;
            }
            return undefined;
        }
        anchors.top: F.isBottom(root.side) ? contents.top : undefined

        h: root.arcActualHeight
        w: root.arcActualWidth

        side: {
            switch (root.side) {
            case PopoutWindow.Side.Top:
                return Arc.Side.BottomLeft;
            case PopoutWindow.Side.Bottom:
                return Arc.Side.TopLeft;
            case PopoutWindow.Side.Left:
                return Arc.Side.TopRight;
            case PopoutWindow.Side.Right:
                return Arc.Side.TopLeft;
            }
        }

        arcColor: Theme.orange0
        fillColor: "transparent"
        fillColor2: root.bgColor
    }
    Arc {
        id: arc4

        anchors.left: {
            if (F.isVert(root.side)) {
                return contents.right;
            } else if (F.isRight(root.side)) {
                return contents.left;
            }
            return undefined;
        }
        anchors.right: (F.isLeft(root.side)) ? contents.right : undefined
        anchors.bottom: (F.isTop(root.side)) ? contents.bottom : undefined
        anchors.top: {
            if (F.isBottom(root.side)) {
                return contents.top;
            } else if (F.isHori(root.side)) {
                return contents.bottom;
            }
            return undefined;
        }

        h: root.arcActualHeight
        w: root.arcActualWidth

        side: {
            switch (root.side) {
            case PopoutWindow.Side.Top:
                return Arc.Side.BottomRight;
            case PopoutWindow.Side.Bottom:
                return Arc.Side.TopRight;
            case PopoutWindow.Side.Left:
                return Arc.Side.BottomRight;
            case PopoutWindow.Side.Right:
                return Arc.Side.BottomLeft;
            }
        }

        arcColor: Theme.orange0
        fillColor: "transparent"
        fillColor2: root.bgColor
    }
    LineLink {
        sx: {
            if (F.isVert(root.side)) {
                return arc3.x;
            } else if (F.isLeft(root.side)) {
                return arc1.x + arc1.width;
            } else if (F.isRight(root.side)) {
                return arc1.x;
            }
        }
        sy: {
            if (F.isTop(root.side)) {
                return arc1.y + arc1.height;
            } else if (F.isBottom(root.side)) {
                return arc1.y;
            } else if (F.isHori(root.side)) {
                return arc3.y;
            }
        }
        ex: (F.isRight(root.side)) ? arc3.x + arc3.width : arc3.x
        ey: {
            if (F.isTop(root.side)) {
                return arc3.y;
            } else if (F.isBottom(root.side)) {
                return arc3.y + arc3.height;
            } else if (F.isHori(root.side)) {
                return arc3.y;
            }
        }
        lineColor: Theme.orange0
        z: 1
    }
    LineLink {
        sx: (F.isLeft(root.side)) ? arc2.x + arc2.width : arc2.x
        sy: (F.isTop(root.side)) ? arc2.y + arc2.height : arc2.y
        ex: {
            if (F.isVert(root.side)) {
                return arc2.x;
            } else if (F.isLeft(root.side)) {
                return arc4.x;
            } else if (F.isRight(root.side)) {
                return arc4.x + arc4.width;
            }
        }
        ey: {
            if (F.isTop(root.side)) {
                return arc4.y;
            } else if (F.isBottom(root.side)) {
                return arc4.y + arc4.height;
            } else if (F.isHori(root.side)) {
                return arc2.y;
            }
        }
        lineColor: Theme.orange0
        z: 1
    }
    LineLink {
        visible: contents.height > 0 && contents.width > 0
        sx: (F.isRight(root.side)) ? arc3.x : arc3.x + arc3.width
        sy: {
            if (F.isTop(root.side)) {
                return arc3.y + arc3.height;
            } else if (F.isBottom(root.side)) {
                return arc3.y;
            } else if (F.isLeft(root.side)) {
                return arc3.y + arc3.height;
            } else if (F.isRight(root.side)) {
                return arc3.y + arc3.height;
            }
        }
        ex: (F.isLeft(root.side)) ? arc4.x + arc4.width : arc4.x
        ey: (F.isTop(root.side)) ? arc4.y + arc4.height : arc4.y

        lineColor: Theme.orange0
        z: 1
    }
    Rectangle {
        id: fillerRect1
        color: root.bgColor
        anchors {
            left: {
                if (F.isLeft(root.side)) {
                    return arc1.left;
                } else if (F.isRight(root.side)) {
                    return arc3.right;
                } else if (F.isVert(root.side)) {
                    return arc1.right;
                }
            }
            right: {
                if (F.isLeft(root.side)) {
                    return arc3.left;
                } else if (F.isRight(root.side)) {
                    return arc1.right;
                } else if (F.isVert(root.side)) {
                    return arc3.right;
                }
            }
            top: {
                if (F.isTop(root.side)) {
                    return contents.top;
                } else if (F.isBottom(root.side)) {
                    return arc3.bottom;
                } else if (F.isHori(root.side)) {
                    return arc1.bottom;
                }
            }
            bottom: {
                if (F.isTop(root.side)) {
                    return arc3.top;
                } else if (F.isBottom(root.side)) {
                    return contents.bottom;
                } else if (F.isHori(root.side)) {
                    return arc3.bottom;
                }
            }
        }
    }
    Rectangle {
        id: fillerRect2
        color: root.bgColor
        anchors {
            left: {
                if (F.isLeft(root.side)) {
                    return arc2.left;
                } else if (F.isRight(root.side)) {
                    return arc3.right;
                } else if (F.isVert(root.side)) {
                    return arc4.left;
                }
            }
            right: {
                if (F.isLeft(root.side)) {
                    return arc4.left;
                } else if (F.isRight(root.side)) {
                    return arc2.right;
                } else if (F.isVert(root.side)) {
                    return arc2.left;
                }
            }
            top: {
                if (F.isTop(root.side)) {
                    return arc2.top;
                } else if (F.isBottom(root.side)) {
                    return arc4.bottom;
                } else if (F.isHori(root.side)) {
                    return arc4.top;
                }
            }
            bottom: {
                if (F.isTop(root.side)) {
                    return arc4.top;
                } else if (F.isBottom(root.side)) {
                    return arc2.bottom;
                } else if (F.isHori(root.side)) {
                    return arc2.top;
                }
            }
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
        visible: height > 0 && width > 0
        implicitWidth: root.w
        implicitHeight: root.h

        anchors {
            horizontalCenter: (F.isVert(root.side)) ? parent.horizontalCenter : undefined
            verticalCenter: (F.isHori(root.side)) ? parent.verticalCenter : undefined
            bottom: F.isBottom(root.side) ? parent.bottom : undefined
            // qmllint disable Quick.anchor-combinations
            left: F.isLeft(root.side) ? parent.left : undefined
            right: F.isRight(root.side) ? parent.right : undefined
        }
        color: root.bgColor

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
                duration: root.animationDuration
            }
        }
        Behavior on width {
            NumberAnimation {
                duration: root.animationDuration
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
