pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property real value: 0
    property int bus: 9

    Process {
        running: true
        command: ["ddcutil", "detect", "--brief", "--skip-ddc-checks"]
        stdout: StdioCollector {
            onStreamFinished: {
                const i = text.search("i2c-") + 4;
                root.bus = text.slice(i, i + 1);
            }
        }
    }

    Process {
        id: ddcGet
        command: ["ddcutil", "-b", root.bus, "getvcp", "10", "--brief", "--skip-ddc-checks"]
        stdout: StdioCollector {
            onStreamFinished: {
                const [, , , cur, max] = text.split(" ");
                root.value = parseInt(cur) / parseInt(max);
            }
        }
    }

    function set(v) {
        Quickshell.execDetached({
            command: ["ddcutil", "-b", root.bus, "setvcp", "10", Math.round(v * 100), "--skip-ddc-checks"]
        });
        root.value = v;
    }

    function get() {
        ddcGet.running = true;
    }

    Component.onCompleted: {
        ddcGet.running = true;
    }
}
