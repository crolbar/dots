import qs.utils
import QtQuick.Layouts
import QtQuick
import Quickshell.Io

// TODO: add more. temperature
Widget {
    id: root
    implicitWidth: 32

    implicitHeight: layout.implicitHeight

    color: "transparent"

    // %
    property real cpuUsage: lastCpuTotal
    property real lastCpuTotal: 0
    property real lastCpuIdle: 0
    // GB
    property double memUsage: 0
    // GB
    property double vramUsage: 5.2

    Process {
        id: cpuProc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var p = data.trim().split(/\s+/);
                var idle = parseInt(p[4]) + parseInt(p[5]);
                var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0);
                if (root.lastCpuTotal > 0) {
                    root.cpuUsage = Math.round(100 * (1 - (idle - root.lastCpuIdle) / (total - root.lastCpuTotal)));
                }
                root.lastCpuTotal = total;
                root.lastCpuIdle = idle;
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: memProc
        command: ["sh", "-c", "free | grep Mem"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var parts = data.trim().split(/\s+/);
                var used = parseInt(parts[2]) || 0;
                root.memUsage = Math.round((used) / 1024 / 1024);
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: vramProc
        command: ["sh", "-c", `nvtop -s | jq -r '.[] | select(.device_name == "AMD Radeon RX 9060 XT") | .mem_used'`]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                var used = parseInt(data) || 0;
                root.vramUsage = Math.round((used) / 1024 / 1024 / 1024);
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true;
            memProc.running = true;
            vramProc.running = true;
        }
    }

    Behavior on implicitHeight {
        NumberAnimation {
            id: hAnim
            duration: 200
        }
    }

    ColumnLayout {
        id: layout
        anchors.horizontalCenter: parent.horizontalCenter
        implicitWidth: 32
        spacing: 4

        Text {
            Layout.alignment: Qt.AlignCenter
            color: Theme.purple0
            text: `${root.vramUsage}`
        }

        Text {
            Layout.alignment: Qt.AlignCenter
            color: (root.memUsage > 18) ? Theme.red1 : Theme.yellow0
            text: `${root.memUsage}`
        }

        Text {
            Layout.alignment: Qt.AlignCenter
            visible: (root.cpuUsage) < 100
            color: Theme.orange0
            text: `${root.cpuUsage}`
        }
    }
}
