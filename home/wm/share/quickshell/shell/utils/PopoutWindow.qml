import Quickshell
import QtQuick
import QtQuick.Effects
import qs.utils

/* TODO:

shadow on arcs
fix arcs breaking (make border out of shape that connect to arc?)
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
    property bool expanded: true

    property bool shadowEnabled: false
    property string shadowColor: "black"
    property int shadowSpace: 20

    property int arcHeight: 40
    property int arcWidth: 40

    // visible: expanded

    implicitHeight: {
        const ss = (shadowEnabled) ? ((side == PopoutWindow.Side.Top || side == PopoutWindow.Side.Bottom) ? shadowSpace / 2 : shadowSpace) : 0;
        // TODO: add arcHeight
        return h + ss;
    }
    implicitWidth: {
        const ss = (shadowEnabled) ? ((side == PopoutWindow.Side.Left || side == PopoutWindow.Side.Right) ? shadowSpace / 2 : shadowSpace) : 0;
        return w + (arcWidth * 2) + ss;
    }

    exclusionMode: ExclusionMode.Ignore

    color: "transparent"

    anchors {
        top: (side == PopoutWindow.Side.Top || anchors.top) ? true : false
        right: (side == PopoutWindow.Side.Right || anchors.right) ? true : false
        bottom: (side == PopoutWindow.Side.Bottom || anchors.bottom) ? true : false
        left: (side == PopoutWindow.Side.Left || anchors.left) ? true : false
    }

    Arc {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: root.shadowSpace / 2
        w: (content.width > root.arcWidth) ? root.arcWidth : content.width
        h: (content.height > root.arcHeight) ? root.arcHeight : content.height

        side: Arc.Side.TopRight

        arcColor: Theme.orange0
        fillColor: "#232323"
    }

    Arc {
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: root.shadowSpace / 2
        w: (content.width > root.arcWidth) ? root.arcWidth : content.width
        h: (content.height > root.arcHeight) ? root.arcHeight : content.height


        side: Arc.Side.TopLeft

        arcColor: Theme.orange0
        fillColor: "#232323"
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

    MultiEffect {
        anchors.fill: content
        source: content
        shadowColor: root.shadowColor
        shadowEnabled: root.shadowEnabled
        z: -1
    }

    Rectangle {
        id: content

        anchors {
            top: (root.side == PopoutWindow.Side.Bottom) ? undefined : parent.top
            right: (root.side == PopoutWindow.Side.Left) ? undefined : parent.right
            bottom: (root.side == PopoutWindow.Side.Top) ? undefined : parent.bottom
            left: (root.side == PopoutWindow.Side.Right) ? undefined : parent.left

            // put margin for shadow to appear, without the side from which the popup appears
            topMargin: {
                const shadowMargin = (root.shadowEnabled && root.side != PopoutWindow.Side.Top) ? root.shadowSpace / 2 : 0;
                return shadowMargin;
            }
            rightMargin: {
                const shadowMargin = (root.shadowEnabled && root.side != PopoutWindow.Side.Right) ? root.shadowSpace / 2 : 0;
                return shadowMargin + root.arcWidth;
            }
            bottomMargin: {
                const shadowMargin = (root.shadowEnabled && root.side != PopoutWindow.Side.Bottom) ? root.shadowSpace / 2 : 0;
                return shadowMargin;
            }
            leftMargin: {
                const shadowMargin = (root.shadowEnabled && root.side != PopoutWindow.Side.Left) ? root.shadowSpace / 2 : 0;
                return shadowMargin + root.arcWidth;
            }
        }

        height: {
            if (root.side != PopoutWindow.Side.Top && root.side != PopoutWindow.Side.Bottom)
                return root.h;
            return (root.expanded) ? root.h : 0;
        }
        width: {
            if (root.side != PopoutWindow.Side.Left && root.side != PopoutWindow.Side.Right)
                return root.w;
            return (root.expanded) ? root.w : 0;
        }
        color: "#232323"

        Behavior on height {
            NumberAnimation {
                duration: 2000
            }
        }
        Behavior on width {
            NumberAnimation {
                duration: 2000
            }
        }

        // border
        // border.color: Theme.orange0
        bottomRightRadius: 10
        bottomLeftRadius: 10
        Rectangle {
            z: -1

            anchors {
                fill: parent
                top: parent.top
                right: parent.right
                bottom: parent.bottom
                left: parent.left

                leftMargin: -1
                rightMargin: -1
                topMargin: (content.height > root.arcHeight) ? root.arcHeight - 5 : 5
                bottomMargin: -1
            }

            bottomRightRadius: parent.bottomRightRadius
            topRightRadius: parent.topRightRadius
            bottomLeftRadius: parent.bottomLeftRadius
            topLeftRadius: parent.topLeftRadius

            color: Theme.orange0
        }

        // onWidthChanged: () => {
        //     console.log(width);
        // }
    }
}
