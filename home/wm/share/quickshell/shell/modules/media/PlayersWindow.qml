pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import qs.utils
import qs.config

PopoutWindow {
    id: root
    required property Config config

    side: PopoutWindow.Side.Right

    anchors.top: true

    margins {
        top: Math.max(config.media_popout_y - height / 2, 0)
        right: {
            return (screen.width / 2) + // middle of screen
            (650 / 2) - // start of dashboard
            8 - 1; // padding
        }
    }

    arcHeight: 10
    arcWidth: 10
    arc2Height: 10
    arc2Width: 10

    bgColor: Theme.bg1
    borderColor: Theme.bg1

    animationDuration: 300
    animationType: Easing.BezierSpline
    animationCurve: [0.38, 1.21, 0.22, 1, 1, 1]

    expanded: config.media_popout_open

    comp: Item {
        implicitHeight: 200
        implicitWidth: layout.implicitWidth

        RowLayout {
            id: layout
            anchors.fill: parent
            spacing: -32

            Repeater {
                model: Brok.players.slice(1).filter(e => e && e.title && e.name).reverse()

                Loader {
                    id: loader
                    required property BrokPlayer modelData
                    Layout.fillHeight: true
                    sourceComponent: Player {
                        player: loader.modelData
                        isFocused: false
                        config: root.config
                    }
                }
            }
        }
    }
}
