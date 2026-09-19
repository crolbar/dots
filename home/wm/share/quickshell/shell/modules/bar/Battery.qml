pragma ComponentBehavior: Bound

import Quickshell.Io
import QtQuick
import qs.utils

Widget {
    id: root

    property int batPerc: -1
    property string batStatus: "Discharging"

    visible: (batPerc != -1)
    implicitWidth: 32
    implicitHeight: (batPerc == -1) ? 0 : text.implicitHeight + 8

    color: "transparent"

    Process {
        id: proc
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT0/capacity",]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                const n = parseInt(this.text);
                if (!Number.isNaN(n))
                    root.batPerc = n;
            }
        }
    }
    Process {
        id: proc2
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT0/status",]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.batStatus = this.text.trim();
            }
        }
    }

    Timer {
        id: t
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            if (root.batPerc == -1) {
                t.running = false;
                return
            }
            proc.running = true;
            proc2.running = true;
        }
    }

    Text {
        id: text
        anchors.horizontalCenter: parent.horizontalCenter
        color: (root.batStatus == "Discharging") ? Theme.orange0 : Theme.blue0
        text: root.batPerc
    }

    Spacer {
        id: spacer
        anchors.top: parent.bottom
    }
}
