import QtQuick
import QtQuick.Layouts
import qs.utils

Item {
    id: root

    readonly property var today: WeatherData.forecast && WeatherData.forecast.length > 0 ? WeatherData.forecast[0] : null

    Component.onCompleted: WeatherData.reload()

    ColumnLayout {
        id: layout

        anchors.fill: parent
        spacing: 0

        RowLayout {
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.fillWidth: true

            Column {
                spacing: -2

                Text {
                    text: WeatherData.city || qsTr("Loading...")
                    font.pixelSize: 22
                    font.weight: Font.DemiBold
                    color: Theme.fg1
                }

                Text {
                    text: new Date().toLocaleDateString(Qt.locale(), "dddd, MMMM d")
                    font.pixelSize: 14
                    color: Theme.fg3
                }
            }

            Item {
                Layout.fillWidth: true
            }

            Row {
                spacing: 24

                WeatherStat {
                    icon: "wb_twilight"
                    label: "Sunrise"
                    value: WeatherData.sunrise
                    colour: Theme.yellow0
                }

                WeatherStat {
                    icon: "bedtime"
                    label: "Sunset"
                    value: WeatherData.sunset
                    colour: Theme.purple0
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            implicitHeight: bigInfoRow.implicitHeight

            radius: 10
            color: Theme.bg1

            RowLayout {
                id: bigInfoRow

                anchors.centerIn: parent
                spacing: 16

                MaterialIcon {
                    Layout.alignment: Qt.AlignVCenter
                    text: WeatherData.icon
                    font.pixelSize: 62
                    color: Theme.fg1
                }

                ColumnLayout {
                    Layout.alignment: Qt.AlignVCenter
                    spacing: -4

                    Text {
                        text: WeatherData.temp
                        font.pixelSize: 32
                        font.weight: Font.Medium
                        color: Theme.fg2
                    }

                    Text {
                        Layout.leftMargin: 2
                        text: WeatherData.description
                        font.pixelSize: 16
                        color: Theme.fg4
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true

            DetailCard {
                icon: "water_drop"
                label: "Humidity"
                value: WeatherData.humidity + "%"
                colour: Theme.blue0
            }
            DetailCard {
                icon: "thermostat"
                label: "Feels Like"
                value: WeatherData.feelsLike
                colour: Theme.yellow0
            }
            DetailCard {
                icon: "air"
                label: "Wind"
                value: WeatherData.windSpeed ? WeatherData.windSpeed + " km/h" : "--"
                colour: Theme.aqua0
            }
        }

        Text {
            Layout.leftMargin: 8
            visible: forecastRepeater.count > 0
            text: qsTr("7-Day Forecast")
            font.pixelSize: 22
            font.weight: Font.DemiBold
            color: Theme.fg1
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Repeater {
                id: forecastRepeater

                model: WeatherData.forecast

                Rectangle {
                    id: forecastItem

                    required property int index
                    required property var modelData

                    Layout.fillWidth: true
                    implicitHeight: forecastItemColumn.implicitHeight + 4 * 2

                    radius: 10
                    color: Theme.bg1

                    ColumnLayout {
                        id: forecastItemColumn

                        anchors.centerIn: parent
                        spacing: 4

                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: forecastItem.index === 0 ? qsTr("Today") : new Date(forecastItem.modelData.date).toLocaleDateString(Qt.locale(), "ddd")
                            font.pixelSize: 18
                            font.weight: Font.DemiBold
                            color: Theme.fg2
                        }

                        Text {
                            Layout.topMargin: -2
                            Layout.alignment: Qt.AlignHCenter
                            text: new Date(forecastItem.modelData.date).toLocaleDateString(Qt.locale(), "MMM d")
                            font.pixelSize: 14
                            opacity: 0.7
                            color: Theme.fg4
                        }

                        MaterialIcon {
                            Layout.alignment: Qt.AlignHCenter
                            text: forecastItem.modelData.icon
                            font.pixelSize: 38
                            color: Theme.fg2
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: {
                                const min = WeatherData.formatTemp(forecastItem.modelData.minTempC).slice(0, -1);
                                const max = WeatherData.formatTemp(forecastItem.modelData.maxTempC).slice(0, -1);
                                return `${max} / ${min}`;
                            }
                            font.pixelSize: 16
                            font.weight: Font.DemiBold
                            color: Theme.fg1
                        }
                    }
                }
            }
        }
    }

    component DetailCard: Item {
        id: detailRoot

        property string icon
        property string label
        property string value
        property color colour

        Layout.fillWidth: true
        Layout.preferredHeight: 40

        Row {
            anchors.centerIn: parent
            spacing: 8

            MaterialIcon {
                text: detailRoot.icon
                color: detailRoot.colour
                font.pixelSize: 34
                anchors.verticalCenter: parent.verticalCenter
            }

            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 0

                Text {
                    text: detailRoot.label
                    font.pixelSize: 16
                    opacity: 0.8
                    horizontalAlignment: Text.AlignLeft
                    color: Theme.fg1
                }
                Text {
                    text: detailRoot.value
                    font.pixelSize: 16
                    font.weight: Font.DemiBold
                    horizontalAlignment: Text.AlignLeft
                    color: Theme.fg1
                }
            }
        }
    }

    component WeatherStat: Row {
        id: weatherStat

        property string icon
        property string label
        property string value
        property color colour

        spacing: 4

        MaterialIcon {
            text: weatherStat.icon
            font.pixelSize: 32
            color: weatherStat.colour
        }

        Column {
            spacing: -1
            Text {
                text: weatherStat.label
                font.pixelSize: 12
                color: Theme.fg3
            }
            Text {
                text: weatherStat.value
                font.pixelSize: 14
                font.weight: Font.DemiBold
                color: Theme.fg1
            }
        }
    }
}
