import Quickshell
import Quickshell.Io
import QtQuick
import "./W.qml"
import "./niri" as Niri

Scope {
    id: root

    property string text
    property var windows: ({})

    W {
        Component.onCompleted: {
            root.windows[this.name] = this;
        }
        onClosed: {
            visible = false;
        }
    }

    Niri.Bar {
        Component.onCompleted: {
            root.windows[this.name] = this;
        }
        onClosed: {
            visible = false;
        }
    }

    Process {
        id: dateProc
        command: ["date"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.text = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }

    IpcHandler {
        target: "main"

        function getWindows(): string {
            let result = "";

            for (let key in root.windows) {
                const w = root.windows[key];
                result += key + ": " + w + "\n";
            }

            return result;
        }

        function open(win: string): string {
            if (!(win in root.windows)) {
                var s = "win: " + win + " not defined";
                console.warn("win:", win, "not defined");
                return s;
            }

            root.windows[win].visible = true;
            return "ok";
        }
        function close(win: string): void {
            if (!(win in root.windows)) {
                var s = "win: " + win + " not defined";
                console.warn("win:", win, "not defined");
                return s;
            }

            root.windows[win].visible = false;
            return "ok";
        }
    }
}
