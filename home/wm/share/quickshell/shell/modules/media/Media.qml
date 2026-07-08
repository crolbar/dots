pragma ComponentBehavior: Bound

import QtQuick
import qs.utils
import qs.config

Loader {
    id: root
    required property Config config

    Component.onCompleted: Brok.start()
    Component.onDestruction: Brok.stop()

    anchors.fill: parent

    active: Brok.players[0] != undefined

    sourceComponent: Player {
        config: root.config
        player: Brok.players[0]
        isFocused: true
    }
}
