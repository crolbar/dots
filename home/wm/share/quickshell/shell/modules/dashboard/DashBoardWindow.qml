pragma ComponentBehavior: Bound

import QtQuick
import qs.utils
import qs.config

PopoutWindow {
    id: root
    required property Config config

    side: PopoutWindow.Side.Top

    bgColor: Theme.bg0

    animationDuration: 200

    HoverHandler {
        onHoveredChanged: {
            if (hovered)
                return;

            if (root.config.media_popout_open)
                return;

            root.expanded = false;
        }
    }

    comp: DashBoard {
        config: root.config
    }
}
