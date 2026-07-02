import Quickshell.Io
import QtQuick.Layouts
import QtQuick
import qs.utils
import qs.modules.bar.audio
import qs.config

Item {
    id: root
    required property Config config
    required property var niri

    implicitWidth: parent.width
    implicitHeight: parent.height

    function mouseEventHandle(y: real): void {
        if (y > widgets.y) {
            widgets.checkPopout(y - widgets.y);
            return;
        }
        root.closeTrayMenu();
        root.closeAudioCtl();
    }

    function mouseWheelHandle(we: WheelEvent): void {
        workspace_wheel.dir = (we.angleDelta.y > 0) ? "up" : "down";
        workspace_wheel.running = true;
    }

    function closeTrayMenu() {
        if (!root.config.selected_tray_item_noexit)
            root.config.selected_tray_item = -1;
    }
    function closeAudioCtl() {
        root.config.bar_popout_audio_ctl_open = false;
    }

    Process {
        id: workspace_wheel
        property string dir
        running: false
        command: {
            ["sh", "-c", `~/.config/niri/eww/scripts/workspace_scroll.sh ${dir}`];
        }
    }

    ColumnLayout {
        spacing: 2

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        Workspaces {
            name: "workspaces"
            workspaces: root.niri.workspaces
        }
    }

    ColumnLayout {
        id: widgets

        // NOTE: not needed, can use containsMouse on each tray item
        function checkPopout(y: real): void {
            const ch = childAt(16, y) as Widget;

            if (ch == null) {
                if (root.config.selected_tray_item != -1)
                    root.closeTrayMenu();
                return;
            }

            if (ch.name == "audio") {
                const audio = ch as Audio;
                if (!root.config.bar_popout_audio_ctl_open) {
                    root.config.bar_popout_audio_ctl_open = true;
                    root.config.bar_popout_audio_ctl_center_y = root.implicitHeight - audio.mapToItem(root, 0, audio.implicitHeight / 2).y;
                }
            }

            if (ch.name == "tray") {
                const tray = ch as Tray;

                const idx = Math.max(Math.floor(((y - tray.y - tray.padding) / tray.implicitHeight) * tray.items.count), 0);
                if (root.config.selected_tray_item == idx)
                    return;

                root.config.selected_tray_item = idx;
                root.config.selected_tray_item_noexit = false;

                const trayItem = tray.items.itemAt(idx);
                if (trayItem) {
                    root.config.selected_tray_item_center_y = root.implicitHeight - trayItem.mapToItem(root, 0, trayItem.implicitHeight / 2).y;
                }
            }

            if (ch.name != "audio") {
                if (root.config.bar_popout_audio_ctl_open)
                    root.closeAudioCtl();
                return;
            }
            if (ch.name != "tray") {
                if (root.config.selected_tray_item != -1)
                    root.closeTrayMenu();
                return;
            }
        }

        spacing: 8

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        KeebLayout {
            name: "keebLayout"
            layout: root.niri.kb_layout
        }

        Audio {
            name: "audio"
        }

        Spacer {
            name: "spacer"
        }

        SysInfo {
            name: "sysInfo"
        }

        Spacer {
            name: "spacer"
        }

        Tray {
            name: "tray"
        }
        Clock {
            name: "clock"
        }
    }
}
