pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.config

Singleton {
    id: root

    property Config config
    property list<BrokPlayer> players
    property string brokctlUpdate

    function start(): void {
        proc.running = true;
    }
    function stop(): void {
        proc.running = false;
    }

    Process {
        id: cbProc
        command: {
            const d = Quickshell.env("XDG_CURRENT_DESKTOP");
            const red_cmd = "echo windows | socat - UNIX-CONNECT:$RED_SOCKET | jq -r '.[] | select(.is_focused == true) | .app_id'";
            const niri_cmd = "niri msg -j focused-window | jq -c -r '.app_id'";
            ["sh", "-c", (d == "red") ? red_cmd : niri_cmd];
        }
        stdout: StdioCollector {
            onStreamFinished: {
                root.cb(text.trim());
            }
        }
    }

    function cb(focusedWindow) {
        // ignoring focused window if we have send a msg to brok
        if (!brokctlUpdate)
            // don't open / close when we are focusing the player*
            if (focusedWindow.toLowerCase().includes(players[0].name ?? ""))
                return;

        // if its open restart close timer, else open
        if (config.media_popout_open) {
            if (config.media_popout_closing_timer)
                config.media_popout_closing_timer.restart();
        } else
            config.media_popout_open = true;
    }

    Process {
        id: proc
        command: ["sh", "-c", "brokctl ru sub"]

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: d => {
                const json = JSON.parse(d);
                const l = [];
                for (const p of json.players) {
                    const component = Qt.createComponent("BrokPlayer.qml");
                    const bp = component.createObject(null, {
                        id: p.id,
                        name: p.name,
                        status: p.status,
                        title: p.title,
                        artist: p.artist,
                        artUri: p.artUri
                    });
                    l.push(bp);
                }
                root.players = l;

                root.brokctlUpdate = json["brokctl-update"];

                cbProc.running = true;
            }
        }
    }
}
