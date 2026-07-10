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

    property bool opened_for_dashboard: false
    onExpandedChanged: {
        if (expanded)
            opened_for_dashboard = !config.media_popout_open;
    }

    margins {
        top: Math.max(config.media_focus_popout_y - height / 2, 0)
        right: {
            if (opened_for_dashboard)
                return (screen.width / 2) + // middle of screen
                (650 / 2) - // start of dashboard
                8 - 1; // padding

            return 180;
        }
    }

    arcHeight: 10
    arcWidth: 10
    arc2Height: 10
    arc2Width: 10

    bgColor: (opened_for_dashboard) ? Theme.bg1 : Theme.bg0
    borderColor: (opened_for_dashboard) ? Theme.bg1 : Theme.bg0

    animationDuration: 300
    animationType: Easing.BezierSpline
    animationCurve: [0.38, 1.21, 0.22, 1, 1, 1]

    expanded: config.media_focus_popout_open

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
