pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property list<BrokPlayer> players
    property string brokctlUpdate

    function start(): void {
        proc.running = true;
    }
    function stop(): void {
        proc.running = false;
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
            }
        }
    }
}
