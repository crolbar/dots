import QtQuick
import Quickshell.Io
import QtQuick.Layouts
import qs.utils

Item {
    id: root

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Component.onCompleted: SystemInfo.start()

    ColumnLayout {
        id: content

        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 4

        /* CPU / GPU */
        RowLayout {
            id: pu
            spacing: 8
            property int cpuUsage: 0
            property int gpuUsage: 0
            Component.onCompleted: {
                cpuUsage = Qt.binding(() => Math.min(SystemInfo.cpuUsage, 100));
                gpuUsage = Qt.binding(() => SystemInfo.gpuUtil);
            }

            Layout.maximumHeight: parent.height / 3
            HeroCard {
                id: cpuCard
                icon: "memory"
                label: qsTr("CPU")
                subLabel: SystemInfo.cpuName
                usage: pu.cpuUsage
                temperature: SystemInfo.cpuTemp
                accent: Theme.orange0
            }

            HeroCard {
                id: gpuCard
                icon: "desktop_windows"
                label: qsTr("GPU")
                subLabel: SystemInfo.gpuName
                usage: pu.gpuUsage
                temperature: SystemInfo.gpuTemp
                accent: Theme.red0
            }
        }

        /* STORAGE / NET / MEMORY */
        RowLayout {
            spacing: 8

            /* STORAGE */
            Rectangle {
                id: storage
                Layout.fillWidth: true
                Layout.maximumWidth: 180
                Layout.fillHeight: true
                radius: 10
                color: Theme.bg0

                property string name: ""
                property int cap: 0
                property int used: 0
                property real perc: 0
                property int percAnim: 0

                Behavior on cap {
                    NumberAnimation {}
                }
                Behavior on used {
                    NumberAnimation {}
                }
                Behavior on percAnim {
                    NumberAnimation {}
                }

                Process {
                    command: ["sh", "-c", "df -h / | sed -n 's/^\\/dev\\/*[[:space:]]*//p'"]

                    stdout: StdioCollector {
                        onStreamFinished: {
                            const [name, _cap, _used] = text.split("  ");
                            storage.name = name;

                            const cap = parseInt(_cap.replace('G', ''));
                            const used = parseInt(_used.replace('G', ''));
                            const perc = (cap > 0) ? used / cap : 0;
                            storage.cap = cap;
                            storage.used = used;
                            storage.perc = perc;
                            storage.percAnim = Math.round(perc * 100);
                        }
                    }
                    Component.onCompleted: running = true
                }

                ColumnLayout {
                    id: row

                    Layout.alignment: Qt.AlignHCenter
                    // spacing: 8

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.margins: 16

                    CircularProgress {
                        Layout.alignment: Qt.AlignHCenter
                        fgColour: Theme.fg3
                        bgColour: Theme.bg1
                        value: storage.perc
                        implicitSize: usageColumn.implicitHeight + 64
                        startAngle: -225
                        sweepAngle: 270
                        strokeWidth: 8

                        ColumnLayout {
                            id: usageColumn

                            anchors.centerIn: parent
                            spacing: 0

                            MaterialIcon {
                                Layout.alignment: Qt.AlignHCenter
                                text: "hard_drive"
                                color: Theme.aqua0
                                font.pointSize: 18
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: storage.percAnim + "%"
                                font.pixelSize: 24
                                font.weight: 800
                                color: Theme.fg1
                            }
                        }
                    }

                    Text {
                        Layout.topMargin: -12
                        Layout.alignment: Qt.AlignHCenter
                        text: storage.name
                        font.pixelSize: 14
                        font.weight: 550
                        color: Theme.fg3
                    }

                    ColumnLayout {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 2

                        Text {
                            text: "Storage"
                            font.pixelSize: 18
                            color: Theme.aqua0
                        }

                        Text {
                            text: `${storage.used} / ${storage.cap} GiB`
                            font.pixelSize: 24
                            font.weight: Font.DemiBold
                            color: Theme.fg1
                        }
                    }
                }
            }

            /* NETWORK */
            Rectangle {
                id: network
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Theme.bg1
                radius: 10

                property real downloadSpeed: 0
                property real uploadSpeed: 0

                Behavior on downloadSpeed {
                    NumberAnimation {}
                    enabled: network.uploadSpeed == 0
                }
                Behavior on uploadSpeed {
                    NumberAnimation {}
                    enabled: network.uploadSpeed == 0
                }

                Component.onCompleted: {
                    NetworkUsage.refCount++;
                    downloadSpeed = Qt.binding(() => NetworkUsage.downloadSpeed ?? 0);
                    uploadSpeed = Qt.binding(() => NetworkUsage.uploadSpeed ?? 0);
                }

                ColumnLayout {
                    id: layout

                    anchors.fill: parent
                    anchors.margins: 16

                    RowLayout {
                        spacing: 2

                        MaterialIcon {
                            text: "swap_vert"
                            color: Theme.fg2
                            font.pixelSize: 18
                            font.weight: Font.DemiBold
                        }

                        Text {
                            text: qsTr("Network")
                            font.pixelSize: 16
                            color: Theme.fg2
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Text {
                            text: {
                                const fmt = NetworkUsage.formatBytes(sparkline.targetMax ?? 0);
                                return `${fmt ? `${fmt.value.toFixed(1)} ${fmt.unit}` : "0.0 B/s"}`;
                            }
                            font.pixelSize: 14
                            color: Theme.fg3
                            font.weight: 400
                        }
                    }

                    Item {
                        Layout.topMargin: 4
                        Layout.bottomMargin: 4
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        SparklineItem {
                            id: sparkline
                            property real targetMax: 1024
                            property real smoothMax: targetMax

                            function getMax() {
                                var dMax = 0.0;
                                var uMax = 0.0;
                                for (const v of NetworkUsage.downloadBuffer)
                                    if (v > dMax)
                                        dMax = v;
                                for (const v of NetworkUsage.uploadBuffer)
                                    if (v > uMax)
                                        uMax = v;
                                return Math.max(dMax, uMax, 1024);
                            }

                            Component.onCompleted: {
                                targetMax = getMax();
                            }

                            anchors.fill: parent

                            line1: NetworkUsage.downloadBuffer
                            line2: NetworkUsage.uploadBuffer

                            historyLength: NetworkUsage.historyLength
                            maxValue: smoothMax
                            line1Color: Theme.blue0
                            line1FillAlpha: 0.25
                            line2Color: Theme.purple0
                            line2FillAlpha: 0.2

                            Connections {
                                function onDownloadBufferChanged(): void {
                                    sparkline.targetMax = sparkline.getMax();
                                    slideAnim.restart();
                                }

                                target: NetworkUsage
                            }

                            Behavior on smoothMax {
                                NumberAnimation {}
                            }

                            NumberAnimation {
                                id: slideAnim
                                target: sparkline
                                property: "slideProgress"
                                from: 0
                                to: 1
                                duration: 1000
                                easing.type: Easing.Linear
                            }
                        }

                        Text {
                            anchors.centerIn: parent
                            text: qsTr("Collecting data...")
                            font.pixelSize: 18
                            color: Theme.fg1
                            visible: NetworkUsage.downloadBuffer.length < 2
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 4

                        MaterialIcon {
                            text: "download"
                            color: Theme.blue0
                            font.pixelSize: 20
                            font.weight: 400
                        }

                        Text {
                            text: qsTr("Download")
                            color: Theme.fg1
                            font.pixelSize: 14
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Text {
                            text: {
                                const fmt = NetworkUsage.formatBytes(network.downloadSpeed);
                                return fmt ? `${fmt.value.toFixed(1)} ${fmt.unit}` : "0.0 B/s";
                            }
                            color: Theme.fg1
                            font.pixelSize: 16
                            font.weight: Font.Medium
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 4

                        MaterialIcon {
                            text: "upload"
                            color: Theme.purple0
                            font.pixelSize: 20
                            font.weight: 400
                        }

                        Text {
                            text: qsTr("Upload")
                            color: Theme.fg1
                            font.pixelSize: 14
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Text {
                            text: {
                                const fmt = NetworkUsage.formatBytes(network.uploadSpeed);
                                return fmt ? `${fmt.value.toFixed(1)} ${fmt.unit}` : "0.0 B/s";
                            }
                            color: Theme.fg1
                            font.pixelSize: 16
                            font.weight: Font.Medium
                        }
                    }
                }
            }

            /* MEMORY */
            Rectangle {
                id: memory
                Layout.preferredWidth: 140
                Layout.fillHeight: true
                color: Theme.bg1
                radius: 10

                property int usage: 0
                property int usageAnim: usage
                property int cap: 1
                property int capAnim: cap
                property int usagePerc: 0

                Component.onCompleted: {
                    usage = Qt.binding(() => SystemInfo.memUsage);
                    cap = Qt.binding(() => SystemInfo.memCap);
                    usagePerc = Qt.binding(() => Math.round((SystemInfo.memUsage / SystemInfo.memCap) * 100));
                }

                Behavior on usageAnim {
                    NumberAnimation {}
                }
                Behavior on capAnim {
                    NumberAnimation {}
                }
                Behavior on usagePerc {
                    NumberAnimation {}
                }

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 8

                    RowLayout {
                        spacing: 8

                        MaterialIcon {
                            text: "memory_alt"
                            color: Theme.yellow0
                            font.pixelSize: 24
                            font.weight: Font.DemiBold
                        }

                        Text {
                            Layout.alignment: Qt.AlignVCenter
                            text: qsTr("Memory")
                            font.pixelSize: 18
                            color: Theme.fg2
                        }
                    }

                    CircularProgress {
                        Layout.topMargin: 16
                        Layout.alignment: Qt.AlignHCenter
                        startAngle: -225
                        sweepAngle: 270
                        implicitSize: memUsageCol.width + 58
                        strokeWidth: 6

                        fgColour: Theme.yellow0
                        value: memory.usage / memory.cap

                        ColumnLayout {
                            id: memUsageCol
                            anchors.centerIn: parent
                            spacing: 0

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: memory.usagePerc + "%"
                                font.pixelSize: 24
                                font.weight: 800
                                color: Theme.fg1
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: qsTr("Used")
                                font.pixelSize: 18
                                color: Theme.fg2
                            }
                        }
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: `${memory.usageAnim} / ${memory.capAnim} GiB`
                        font.pixelSize: 20
                        color: Theme.fg1
                        font.weight: 450
                    }
                }
            }
        }
    }

    component HeroCard: Rectangle {
        id: root

        required property string icon
        required property string label
        required property string subLabel
        required property color accent
        required property real usage
        required property real temperature

        property int usageAnim: 0
        property int tempAnim: 0
        Behavior on usageAnim {
            NumberAnimation {}
        }
        Behavior on tempAnim {
            NumberAnimation {}
        }
        Component.onCompleted: {
            usageAnim = Qt.binding(() => usage);
            tempAnim = Qt.binding(() => temperature);
        }

        color: Theme.bg1
        radius: 15

        Layout.fillWidth: true
        Layout.fillHeight: true

        CircularProgress {
            id: tempProg

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 8

            fgColour: root.accent

            spacing: 2
            strokeWidth: 3
            implicitSize: Math.max(icon.implicitWidth, icon.implicitHeight) / 2 + 16 * 2
            value: Math.min(Math.max(root.usage / 100, 0), 1)

            MaterialIcon {
                id: icon

                anchors.centerIn: parent
                text: root.icon
                color: Theme.fg2
                font.pixelSize: 18
            }
        }

        ColumnLayout {
            id: labels
            anchors.left: tempProg.right
            anchors.right: usageShape.left
            anchors.top: parent.top
            anchors.margins: 6
            spacing: 0

            Text {
                text: root.label
                font.pixelSize: 16
                color: root.accent
            }

            Text {
                Layout.fillWidth: true
                text: root.subLabel
                font.pixelSize: 16
                font.weight: 550
                color: Theme.fg2
                elide: Text.ElideRight
            }
        }

        ColumnLayout {
            id: tempRow

            anchors.left: parent.left
            anchors.right: usageShape.left
            anchors.bottom: parent.bottom
            anchors.margins: 16
            anchors.rightMargin: 6
            spacing: 6

            RowLayout {
                Layout.leftMargin: -2
                spacing: 2

                MaterialIcon {
                    Layout.topMargin: Math.round(fontInfo.pointSize * 0.08)
                    text: root.temperature > 85 ? "thermometer_alert" : "thermometer"
                    color: root.temperature > 85 ? Theme.red1 : Theme.fg3
                    font.pixelSize: 16
                    font.weight: 500
                }

                Text {
                    text: `${root.tempAnim}°C`
                    color: Theme.fg2
                    font.pixelSize: 16
                    font.weight: Font.Medium
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.rightMargin: 16
                color: Theme.bg0
                implicitHeight: 3

                radius: 10

                Rectangle {
                    radius: 10
                    implicitHeight: 3
                    color: root.accent
                    implicitWidth: parent.width * (root.tempAnim / 100.0)
                }
            }
        }

        Rectangle {
            id: usageShape

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 6
            anchors.bottomMargin: 10

            radius: 10
            implicitWidth: implicitHeight
            implicitHeight: 60
            color: Theme.bg0

            Text {
                id: usageLabel

                anchors.bottom: parent.top
                anchors.bottomMargin: 8
                anchors.horizontalCenter: parent.horizontalCenter

                text: qsTr("Usage")
                color: Theme.fg2
                font.pixelSize: 16
            }

            Text {
                anchors.centerIn: parent
                text: root.usageAnim + "%"
                color: Theme.fg1
                font.pixelSize: 24
                font.weight: 800
            }
        }
    }
}
