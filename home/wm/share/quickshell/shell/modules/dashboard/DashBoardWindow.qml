import QtQuick
import qs.utils
import qs.config

PopoutWindow {
    id: root
    required property Config config

    side: PopoutWindow.Side.Top

    bgColor: Theme.bg0

    animationDuration: 200

    comp: DashBoard {}
}
