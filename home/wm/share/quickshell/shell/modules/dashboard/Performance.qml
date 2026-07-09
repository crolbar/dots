import QtQuick
import Quickshell.Io
import QtQuick.Effects
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
            spacing: 8

            Layout.maximumHeight: parent.height / 3
            HeroCard {
                id: cpuCard
                icon: "memory"
                label: qsTr("CPU")
                subLabel: SystemInfo.cpuName
                usage: Math.min(SystemInfo.cpuUsage, 100)
                temperature: SystemInfo.cpuTemp
                accent: Theme.red0
            }

            HeroCard {
                id: gpuCard
                icon: "desktop_windows"
                label: qsTr("GPU")
                subLabel: SystemInfo.gpuName
                usage: SystemInfo.gpuUtil
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
                property real perc: (storage.cap > 0) ? storage.used / storage.cap : 0

                Process {
                    command: ["sh", "-c", "df -h / | sed -n 's/^\\/dev\\/*[[:space:]]*//p'"]

                    stdout: StdioCollector {
                        onStreamFinished: {
                            const [name, cap, used] = text.split("  ");
                            storage.name = name;
                            storage.cap = parseInt(cap.replace('G', ''));
                            storage.used = parseInt(used.replace('G', ''));
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
                                color: Theme.fg2
                                font.pointSize: 18
                            }

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: Math.round(storage.perc * 100) + "%"
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
                        color: Theme.blue0
                    }

                    ColumnLayout {
                        Layout.alignment: Qt.AlignHCenter
                        spacing: 2

                        Text {
                            text: "Storage"
                            font.pixelSize: 18
                            // font.weight: 600
                            color: Theme.fg2
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
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: Theme.bg1
                radius: 10

                Component.onCompleted: NetworkUsage.refCount++

                ColumnLayout {
                    id: layout

                    anchors.fill: parent
                    anchors.margins: 16
                    anchors.bottomMargin: 4
                    spacing: 0

                    RowLayout {
                        spacing: 2

                        MaterialIcon {
                            text: "swap_vert"
                            color: Theme.fg1
                            // fontStyle: Tokens.font.icon.medium
                        }

                        Text {
                            text: qsTr("Network")
                            color: Theme.fg1
                            // font: Tokens.font.title.medium
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

                            anchors.fill: parent

                            line1: NetworkUsage.downloadBuffer
                            line2: NetworkUsage.uploadBuffer

                            anchors.margins: 12
                            historyLength: NetworkUsage.historyLength
                            maxValue: smoothMax
                            line1Color: Theme.blue0
                            line1FillAlpha: 0.25
                            line2Color: Theme.purple0
                            line2FillAlpha: 0.2

                            Connections {
                                function onDownloadBufferChanged(): void {
                                    var dMax = 0.0;
                                    var uMax = 0.0;
                                    for (const v of NetworkUsage.downloadBuffer)
                                        if (v > dMax)
                                            dMax = v;
                                    for (const v of NetworkUsage.uploadBuffer)
                                        if (v > uMax)
                                            uMax = v;

                                    sparkline.targetMax = Math.max(dMax, uMax, 1024);
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
                            // font: Tokens.font.body.small
                            color: Theme.fg1
                            visible: NetworkUsage.downloadBuffer.length < 2
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 2

                        MaterialIcon {
                            text: "download"
                            color: Theme.fg1
                            // fontStyle: Tokens.font.icon.medium
                        }

                        Text {
                            text: qsTr("Download")
                            // font: Tokens.font.body.small
                            color: Theme.fg1
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Text {
                            text: {
                                const fmt = NetworkUsage.formatBytes(NetworkUsage.downloadSpeed ?? 0);
                                return fmt ? `${fmt.value.toFixed(1)} ${fmt.unit}` : "0.0 B/s";
                            }
                            // font: Tokens.font.body.builders.medium.weight(Font.Medium).build()
                            color: Theme.fg1
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 2

                        MaterialIcon {
                            text: "upload"
                            color: Theme.fg1
                            // fontStyle: Tokens.font.icon.medium
                        }

                        Text {
                            text: qsTr("Upload")
                            // font: Tokens.font.body.small
                            color: Theme.fg1
                        }

                        Item {
                            Layout.fillWidth: true
                        }

                        Text {
                            text: {
                                const fmt = NetworkUsage.formatBytes(NetworkUsage.uploadSpeed ?? 0);
                                return fmt ? `${fmt.value.toFixed(1)} ${fmt.unit}` : "0.0 B/s";
                            }
                            // font: Tokens.font.body.builders.medium.weight(Font.Medium).build()
                            color: Theme.fg1
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
                        value: SystemInfo.memUsage / SystemInfo.memCap

                        ColumnLayout {
                            id: memUsageCol
                            anchors.centerIn: parent
                            spacing: 0

                            Text {
                                Layout.alignment: Qt.AlignHCenter
                                text: Math.round((SystemInfo.memUsage / SystemInfo.memCap) * 100) + "%"
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
                        text: `${SystemInfo.memUsage} / ${SystemInfo.memCap} GiB`
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

        color: Theme.bg1
        radius: 15

        Layout.fillWidth: true
        Layout.fillHeight: true

        CircularProgress {
            id: tempProg

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.margins: 8

            fgColour: Theme.fg3

            spacing: 2
            strokeWidth: 2
            implicitSize: Math.max(icon.implicitWidth, icon.implicitHeight) / 2 + 16 * 2
            value: Math.min(Math.max(root.usage / 100, 0), 1)

            MaterialIcon {
                id: icon

                anchors.centerIn: parent
                text: root.icon
                color: Theme.fg3
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
                color: Theme.fg2
            }

            Text {
                Layout.fillWidth: true
                text: root.subLabel
                font.pixelSize: 16
                font.weight: Font.DemiBold
                color: root.accent
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
                    color: root.temperature > 85 ? Theme.red1 : Theme.fg1
                    font.pixelSize: 16
                }

                Text {
                    text: `${root.temperature}°C`
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
                    color: Theme.fg1
                    implicitWidth: parent.width * (root.temperature / 100.0)

                    Behavior on implicitWidth {
                        NumberAnimation {}
                    }
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
                text: isNaN(root.usage) ? "...%" : root.usage + "%"
                color: Theme.fg1
                font.pixelSize: 24
                font.weight: 800
            }
        }
    }
}
