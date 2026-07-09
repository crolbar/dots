pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    // GB
    property double memCap: 0
    property double memUsage: 0
    property string cpuName: ""
    // %
    property real cpuUsage: lastCpuTotal
    property real lastCpuTotal: 0
    property real lastCpuIdle: 0
    property real cpuTemp: 0

    property string gpuName: "AMD Radeon RX 9060 XT"
    // GB
    property double vramUsage: 0
    // %
    property real gpuUtil: 0
    property real gpuTemp: 0

    Process {
        id: cpuNameProc
        command: ["sh", "-c", "lscpu | sed -n 's/^Model name:[[:space:]]*//p'"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                root.cpuName = data;
            }
        }
        Component.onCompleted: running = true
    }

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
                var cap = parseInt(parts[1]) || 0;
                var used = parseInt(parts[2]) || 0;
                root.memUsage = Math.round((used) / 1024 / 1024);
                root.memCap = Math.round((cap) / 1024 / 1024);
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: tempProc
        command: ["sh", "-c", "cat /sys/class/hwmon/hwmon5/temp3_input"]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                root.cpuTemp = Math.floor((parseInt(data) || 0) / 1000);
            }
        }
        Component.onCompleted: running = true
    }

    Process {
        id: gpuProc
        command: ["sh", "-c", `nvtop -s | jq -r -c '.[] | select(.device_name == "AMD Radeon RX 9060 XT") | {mem_used, temp, gpu_util}'`]
        stdout: SplitParser {
            onRead: data => {
                if (!data)
                    return;
                const json = JSON.parse(data);
                var used = parseInt(json.mem_used) || 0;
                root.vramUsage = Math.round((used) / 1024 / 1024 / 1024);

                root.gpuUtil = json.gpu_util.replace('%', '');
                root.gpuTemp = json.temp.replace('C', '');
            }
        }
        Component.onCompleted: running = true
    }

    Timer {
        id: timer
        interval: 2000
        repeat: true
        onTriggered: {
            cpuProc.running = true;
            memProc.running = true;
            gpuProc.running = true;
            tempProc.running = true;
        }
    }

    function start() {
        if (!timer.running)
            timer.running = true;
    }
}
