import QtQuick
import QtQuick.Layouts
import App.Style
import "Components"

// AutoPilot Pro — otonom sürüş kontrol merkezi.
// Resizable desktop window: Layouts reflow; nothing is scaled.
Window {
    id: window

    width: Theme.designWidth
    height: Theme.designHeight
    minimumWidth: 960
    minimumHeight: 600
    visible: true
    color: Theme.bg
    title: qsTr("AutoPilot Pro")

    // ---- icon helpers ----------------------------------------------------
    // Each exported SVG lives in its own folder; the inner file name does not
    // always match the folder (e.g. mappin-muted.svg/map-pin.svg).
    readonly property var iconFiles: ({
        "home-white": "home",       "home-muted": "home",
        "video-muted": "video",     "mappin-muted": "map-pin",   "pin-green": "map-pin",
        "steering-muted": "steering-wheel", "gauge-muted": "gauge", "zap-muted": "zap",
        "database-muted": "database", "settings-muted": "settings",
        "car-blue": "car",          "car-white": "car",         "user-purple": "user",
        "bicycle-orange": "bicycle","scan-gray": "scan",
        "thermo-cyan": "thermometer", "battery-cyan": "battery-charging",
        "cloudsun-white": "cloud-sun", "bell-white": "bell",
        "carfront-blue": "car-front", "carfront-caminfo": "car-front",
        "route-green": "route",     "parking-gray": "square-parking",
        "nav-blue": "navigation",   "nav-gray": "navigation"
    })

    function iconUrl(dir) { return "../../assets/icons/" + dir + ".svg/" + iconFiles[dir] + ".svg" }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // ============================ top bar =============================
        Rectangle {
            Layout.preferredHeight: 67
            Layout.fillWidth: true
            color: Theme.topbarBg

            RowLayout {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                leftMargin: 20
                rightMargin: 16
                spacing: 0

                // logo block — fixed width so the divider sits at x≈245
                RowLayout {
                    Layout.preferredWidth: 225
                    spacing: Theme.space6

                    Image {
                        source: iconUrl("carfront-blue")
                        sourceSize.width: 30
                        sourceSize.height: 30
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                    }
                    ColumnLayout {
                        spacing: 0
                        Text { text: qsTr("AutoPilot Pro"); font: Theme.text21Normal; color: Theme.textPrimary }
                        Text { text: qsTr("Otonom Sürüş Sistemi"); font: Theme.text13Normal; color: Theme.textMuted }
                    }
                }

                Rectangle { width: 1; Layout.preferredHeight: 34; color: Theme.borderSubtle }
                Item { Layout.preferredWidth: Theme.space13 }

                // system status
                RowLayout {
                    spacing: Theme.space5
                    Rectangle { width: 8; height: 8; radius: 4; color: Theme.green }
                    ColumnLayout {
                        spacing: 0
                        Text { text: qsTr("Sistem Aktif"); font: Theme.text16Normal; color: Theme.textPrimary }
                        Text { text: qsTr("Otonom Sürüş Modu"); font: Theme.text12Normal; color: Theme.textFaint }
                    }
                }

                Item { Layout.fillWidth: true }

                // weather
                RowLayout {
                    spacing: Theme.space5
                    Image {
                        source: iconUrl("cloudsun-white")
                        sourceSize.width: 20
                        sourceSize.height: 20
                        Layout.preferredWidth: 20
                        Layout.preferredHeight: 20
                    }
                    ColumnLayout {
                        spacing: 0
                        Text { text: qsTr("18°C"); font: Theme.text16Normal; color: Theme.textPrimary }
                        Text { text: qsTr("İstanbul"); font: Theme.text13Normal; color: Theme.legendBlue }
                    }
                }

                Item { Layout.preferredWidth: Theme.space13 }
                Rectangle { width: 1; Layout.preferredHeight: 34; color: Theme.borderSubtle }
                Item { Layout.preferredWidth: Theme.space13 }

                // clock (no icon asset — drawn)
                RowLayout {
                    spacing: Theme.space5
                    Item {
                        implicitWidth: 20
                        implicitHeight: 20
                        Shape {
                            anchors.fill: parent
                            antialiasing: true
                            // circle as two semicircle arcs (no PathCircle type)
                            PathLine { x: 1.5; y: 10 }
                            PathArc { x: 18.5; y: 10; xRadius: 8.5; yRadius: 8.5
                                      sweepDirection: ArcSweep.Clockwise; largeArc: false }
                            PathArc { x: 1.5; y: 10; xRadius: 8.5; yRadius: 8.5
                                      sweepDirection: ArcSweep.Clockwise; largeArc: false }
                            PathLine { x: 10; y: 10 } PathLine { x: 10; y: 4 }    // minute hand up
                            PathLine { x: 10; y: 10 } PathLine { x: 13.5; y: 10 } // hour hand right
                            strokeColor: Theme.textSoft
                            strokeWidth: 1.5
                        }
                    }
                    ColumnLayout {
                        spacing: 0
                        Text { text: qsTr("14:37"); font: Theme.text16Normal; color: Theme.textPrimary }
                        Text { text: qsTr("25 Nisan 2025"); font: Theme.text12Normal; color: Theme.textFaint }
                    }
                }

                Item { Layout.preferredWidth: Theme.space13 }
                Rectangle { width: 1; Layout.preferredHeight: 34; color: Theme.borderSubtle }
                Item { Layout.preferredWidth: Theme.space13 }

                // GPS + signal (no icon assets — drawn)
                RowLayout {
                    spacing: Theme.space5
                    Item {
                        implicitWidth: 20
                        implicitHeight: 20
                        Shape {
                            anchors.fill: parent
                            antialiasing: true
                            // three arcs over a dot, centered at (10, 15)
                            PathLine { x: 10 + 4.5 * Math.cos(225 * Math.PI / 180); y: 15 + 4.5 * Math.sin(225 * Math.PI / 180) }
                            PathArc {
                                x: 10 + 4.5 * Math.cos(315 * Math.PI / 180)
                                y: 15 + 4.5 * Math.sin(315 * Math.PI / 180)
                                xRadius: 4.5
                                yRadius: 4.5
                                sweepDirection: ArcSweep.Clockwise
                                largeArc: false
                            }
                            PathLine { x: 10 + 8 * Math.cos(225 * Math.PI / 180); y: 15 + 8 * Math.sin(225 * Math.PI / 180) }
                            PathArc {
                                x: 10 + 8 * Math.cos(315 * Math.PI / 180)
                                y: 15 + 8 * Math.sin(315 * Math.PI / 180)
                                xRadius: 8
                                yRadius: 8
                                sweepDirection: ArcSweep.Clockwise
                                largeArc: false
                            }
                            PathLine { x: 10 + 11.5 * Math.cos(225 * Math.PI / 180); y: 15 + 11.5 * Math.sin(225 * Math.PI / 180) }
                            PathArc {
                                x: 10 + 11.5 * Math.cos(315 * Math.PI / 180)
                                y: 15 + 11.5 * Math.sin(315 * Math.PI / 180)
                                xRadius: 11.5
                                yRadius: 11.5
                                sweepDirection: ArcSweep.Clockwise
                                largeArc: false
                            }
                            strokeColor: Theme.gpsGreen
                            strokeWidth: 1.8
                            capStyle: Shape.Round
                        }
                        Rectangle {
                            anchors.horizontalCenter: parent.horizontalCenter
                            y: 13.5
                            width: 3
                            height: 3
                            radius: 1.5
                            color: Theme.gpsGreen
                        }
                    }
                    ColumnLayout {
                        spacing: 0
                        Text { text: qsTr("GPS"); font: Theme.text14Normal; color: Theme.textPrimary }
                        Text { text: qsTr("10/10"); font: Theme.text12Normal; color: Theme.gpsGreen }
                    }
                    Item {
                        implicitWidth: 29
                        implicitHeight: 20
                        Repeater {
                            model: [8, 12, 16, 20]
                            delegate: Rectangle {
                                x: index * 8
                                width: 5
                                height: modelData
                                anchors.bottom: parent.bottom
                                color: Theme.greenBright
                            }
                        }
                    }
                }

                Item { Layout.preferredWidth: Theme.space13 }
                Image {
                    source: iconUrl("bell-white")
                    sourceSize.width: 20
                    sourceSize.height: 20
                    Layout.preferredWidth: 20
                    Layout.preferredHeight: 20
                }
                Item { Layout.preferredWidth: Theme.space13 }
                Image {
                    source: iconUrl("settings-muted")
                    sourceSize.width: 20
                    sourceSize.height: 20
                    Layout.preferredWidth: 20
                    Layout.preferredHeight: 20
                }

                Item { Layout.fillWidth: true }

                // window controls (no icon assets — drawn)
                RowLayout {
                    spacing: Theme.space8
                    Rectangle { width: 12; height: 2; color: Theme.textMuted }   // minimize
                    Rectangle {                                                  // maximize
                        width: 12
                        height: 12
                        color: "transparent"
                        border.color: Theme.textMuted
                        border.width: 1
                    }
                    Item {                                                      // close
                        implicitWidth: 12
                        implicitHeight: 12
                        Shape {
                            anchors.fill: parent
                            antialiasing: true
                            PathLine { x: 0; y: 0 } PathLine { x: 12; y: 12 }
                            PathLine { x: 12; y: 0 } PathLine { x: 0; y: 12 }
                            strokeColor: Theme.textMuted
                            strokeWidth: 1.5
                        }
                    }
                }
            }
        }

        // ============================ body row =============================
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            // ------------------------- sidebar -----------------------------
            Rectangle {
                Layout.preferredWidth: 278
                Layout.fillHeight: true
                color: Theme.sidebarBg

                ColumnLayout {
                    anchors.fill: parent
                    leftMargin: 14
                    rightMargin: 14
                    topMargin: 26
                    bottomMargin: 24
                    spacing: 20

                    Repeater {
                        model: MockData.navItems
                        NavItem {
                            Layout.fillWidth: true
                            label: model.label
                            active: model.active
                            // only "home" ships a white variant; the rest use muted
                            iconSource: model.active ? iconUrl("home-white")
                                                     : iconUrl(model.icon + "-muted")
                        }
                    }

                    Item { Layout.fillHeight: true }

                    // vehicle card pinned to the bottom of the sidebar
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 257
                        radius: Theme.radiusR10
                        color: Theme.panelBg
                        border.color: Theme.borderSubtle
                        border.width: 1

                        ColumnLayout {
                            anchors.centerIn: parent
                            spacing: 8

                            Image {
                                source: "../../assets/tesla_car.png"
                                Layout.preferredWidth: 200
                                fillMode: Image.PreserveAspect
                            }
                            Text {
                                text: MockData.vehicleModel
                                font: Theme.text16Normal
                                color: Theme.textPrimary
                                Layout.alignment: Qt.AlignHCenter
                            }
                            Text {
                                text: MockData.vin
                                font: Theme.text13Normal
                                color: Theme.textFaint
                                Layout.alignment: Qt.AlignHCenter
                            }
                            RowLayout {
                                spacing: 6
                                Rectangle { width: 8; height: 8; radius: 4; color: Theme.green }
                                Text { text: qsTr("Bağlı"); font: Theme.text14Normal; color: Theme.gpsGreen }
                            }
                        }
                    }
                }
            }

            // ------------------------- content -----------------------------
            ColumnLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                leftMargin: 18
                rightMargin: 18
                topMargin: 15
                bottomMargin: 30
                spacing: 17

                RowLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 18

                    // ---------- center column ----------
                    ColumnLayout {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        spacing: 17

                        // camera panel
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            radius: Theme.radiusR12
                            color: "transparent"
                            border.color: Theme.borderSubtle
                            border.width: 1
                            clip: true

                            Image {
                                id: camImage
                                anchors.fill: parent
                                source: "../../assets/camera_view.png"
                                fillMode: Image.PreserveAspectCrop
                            }

                            // dark scrim behind the title for legibility
                            Rectangle {
                                anchors.top: parent.top
                                anchors.left: parent.left
                                anchors.right: parent.right
                                height: 41
                                gradient: Gradient {
                                    orientation: Gradient.Vertical
                                    GradientStop { position: 0.0; color: Theme.scrim }
                                    GradientStop { position: 1.0; color: "transparent" }
                                }
                            }

                            RowLayout {
                                anchors.top: parent.top
                                leftMargin: 18
                                topMargin: 12
                                spacing: 6
                                Rectangle { width: 8; height: 8; radius: 4; color: Theme.detectRed }
                                Text { text: qsTr("Ön Kamera - Canlı Görüntü"); font: Theme.text15Normal; color: Theme.textPrimary }
                            }

                            // detection overlays — panel-local design px scaled to the live size
                            Item {
                                id: camOverlay
                                anchors.fill: parent
                                Repeater {
                                    model: MockData.detections
                                    DetectionBox {
                                        label: model.label
                                        boxColor: model.color
                                        width: model.w * (camOverlay.width / 967)
                                        height: model.h * (camOverlay.height / 573)
                                        x: model.x * (camOverlay.width / 967)
                                        y: model.y * (camOverlay.height / 573)
                                    }
                                }
                            }

                            // resolution chip, bottom-left
                            Rectangle {
                                anchors.bottom: parent.bottom
                                anchors.left: parent.left
                                bottomMargin: 14
                                leftMargin: 16
                                radius: Theme.radiusR10
                                color: Theme.pillDark
                                width: camChipRow.implicitWidth + 24
                                height: 28

                                RowLayout {
                                    id: camChipRow
                                    anchors.centerIn: parent
                                    spacing: 6
                                    Rectangle { width: 7; height: 7; radius: 3.5; color: Theme.greenBright }
                                    Text { text: qsTr("1080p · 30 FPS"); font: Theme.text12Normal; color: Theme.camInfo }
                                }
                            }

                            // compass, bottom-right
                            Rectangle {
                                anchors.bottom: parent.bottom
                                anchors.right: parent.right
                                bottomMargin: 14
                                rightMargin: 16
                                width: 56
                                height: 56
                                radius: Theme.radiusR28
                                color: Theme.pillDark
                                border.color: Theme.borderSubtle
                                border.width: 1

                                ColumnLayout {
                                    anchors.centerIn: parent
                                    spacing: 0
                                    Text { text: qsTr("N"); font: Theme.text13Normal; color: Theme.textSoft }
                                    Image {
                                        source: iconUrl("nav-gray")
                                        sourceSize.width: 14
                                        sourceSize.height: 14
                                        Layout.preferredWidth: 14
                                        Layout.preferredHeight: 14
                                    }
                                }
                            }
                        }

                        // bottom row of three panels
                        RowLayout {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 235
                            spacing: 18

                            Card {
                                Layout.fillWidth: true
                                title: qsTr("Sürüş Verileri")

                                headerRight: Repeater {
                                    model: MockData.chartLegend
                                    RowLayout {
                                        spacing: Theme.space4
                                        Rectangle { width: 8; height: 8; radius: 4; color: model.color }
                                        Text { text: model.label; font: Theme.text12Normal; color: Theme.legendMuted }
                                    }
                                }

                                LineChart {
                                    seriesData: [MockData.speedSeries, MockData.rpmSeries, MockData.batterySeries]
                                    times: MockData.chartTimes
                                }
                            }

                            Card {
                                Layout.preferredWidth: 289
                                title: qsTr("Kamera Derinlik Haritası")

                                headerRight: CloseIcon {}

                                RowLayout {
                                    spacing: 10
                                    Rectangle {
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                        radius: Theme.radiusR6
                                        color: "transparent"
                                        clip: true
                                        Image { anchors.fill: parent; source: "../../assets/depth_map.png"; fillMode: Image.PreserveAspectCrop }
                                    }
                                    ColumnLayout {
                                        Layout.fillHeight: true
                                        spacing: 4
                                        Text { text: qsTr("Uzak"); font: Theme.text11Normal; color: Theme.textSoft }
                                        Rectangle {
                                            Layout.fillHeight: true
                                            width: 8
                                            radius: Theme.radiusR4
                                            gradient: Gradient {
                                                orientation: Gradient.Vertical
                                                GradientStop { position: 0.00; color: Theme.accentBlue }
                                                GradientStop { position: 0.20; color: Theme.cyanIcon }
                                                GradientStop { position: 0.40; color: Theme.greenBright }
                                                GradientStop { position: 0.60; color: Theme.chartOrange }
                                                GradientStop { position: 0.80; color: Theme.speedLimitRed }
                                                GradientStop { position: 1.00; color: Theme.detectPurple }
                                            }
                                        }
                                        Text { text: qsTr("Yakın"); font: Theme.text11Normal; color: Theme.textSoft }
                                    }
                                }
                            }

                            Card {
                                Layout.preferredWidth: 241
                                title: qsTr("Nesne Sayıları")

                                headerRight: CloseIcon {}

                                ColumnLayout {
                                    spacing: 0
                                    Repeater {
                                        model: MockData.objectCounts
                                        RowLayout {
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            spacing: Theme.space6
                                            Rectangle {
                                                width: 32
                                                height: 32
                                                radius: Theme.radiusR16
                                                color: Theme.iconCircleBg
                                                Image {
                                                    anchors.centerIn: parent
                                                    source: iconUrl(model.icon)
                                                    sourceSize.width: 18
                                                    sourceSize.height: 18
                                                }
                                            }
                                            Text { text: model.label; font: Theme.text14Normal; color: Theme.textSoft; Layout.fillWidth: true }
                                            Text { text: String(model.count); font: Theme.text17Normal; color: Theme.textPrimary }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // ---------- right column ----------
                    ColumnLayout {
                        Layout.preferredWidth: 372
                        Layout.fillHeight: true
                        spacing: 16

                        Card {
                            title: qsTr("Hız")
                            titleDotColor: Theme.cyanIcon
                            Layout.preferredHeight: 209

                            RowLayout {
                                spacing: 8
                                SpeedGauge {
                                    value: MockData.currentSpeed
                                    maxSpeed: MockData.speedLimit
                                    Layout.fillWidth: true
                                }
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 4
                                    Item {
                                        Layout.fillWidth: true
                                        implicitHeight: 44
                                        Rectangle {   // speed-limit badge, top-right
                                            anchors.right: parent.right
                                            width: 40
                                            height: 40
                                            radius: Theme.radiusR20
                                            color: Theme.btnIdleBg
                                            border.color: Theme.speedLimitRed
                                            border.width: 2
                                            Text {
                                                anchors.centerIn: parent
                                                text: String(MockData.speedLimit)
                                                font: Theme.text16Normal
                                                color: Theme.textPrimary
                                            }
                                        }
                                    }
                                    ColumnLayout { spacing: 1
                                        Text { text: qsTr("Güncel Hız"); font: Theme.text13Normal; color: Theme.textFaint }
                                        Text { text: MockData.currentSpeed + " " + qsTr("km/s"); font: Theme.text17Normal; color: Theme.textPrimary }
                                    }
                                    ColumnLayout { spacing: 1
                                        Text { text: qsTr("Hedef Hız"); font: Theme.text13Normal; color: Theme.textFaint }
                                        Text { text: MockData.targetSpeed + " " + qsTr("km/s"); font: Theme.text17Normal; color: Theme.textPrimary }
                                    }
                                }
                            }
                        }

                        Card {
                            title: qsTr("Batarya Durumu")
                            Layout.preferredHeight: 134

                            headerRight: CloseIcon {}

                            ColumnLayout {
                                spacing: 8
                                RowLayout {
                                    spacing: 10
                                    Rectangle {
                                        Layout.fillWidth: true
                                        height: 22
                                        radius: Theme.radiusR11
                                        color: Theme.btnIdleBg
                                        Rectangle {
                                            anchors.left: parent.left
                                            anchors.top: parent.top
                                            anchors.bottom: parent.bottom
                                            width: parent.width * MockData.batteryPercent / 100
                                            radius: Theme.radiusR11
                                            gradient: Gradient {
                                                orientation: Gradient.Horizontal
                                                GradientStop { position: 0.0; color: Theme.green }
                                                GradientStop { position: 1.0; color: Theme.greenBright }
                                            }
                                        }
                                    }
                                    Text { text: MockData.batteryPercent + "%"; font: Theme.text16Normal; color: Theme.textPrimary }
                                }
                                RowLayout {
                                    spacing: 8
                                    ColumnLayout { Layout.fillWidth: true; spacing: 1
                                        Text { text: qsTr("Kalan Menzil"); font: Theme.text13Normal; color: Theme.textFaint }
                                        Text { text: MockData.remainingRange; font: Theme.text15Normal; color: Theme.valueSoft }
                                    }
                                    ColumnLayout { spacing: 1
                                        Text { text: qsTr("Tahmini Süre"); font: Theme.text13Normal; color: Theme.textFaint }
                                        Text { text: MockData.estimatedTime; font: Theme.text15Normal; color: Theme.valueSoft }
                                    }
                                }
                            }
                        }

                        Card {
                            title: qsTr("Motor Sıcaklıkları")
                            titleDotColor: Theme.cyanIcon
                            Layout.preferredHeight: 94

                            RowLayout {
                                spacing: 0
                                Repeater {
                                    model: MockData.motorTemps
                                    ColumnLayout {
                                        Layout.fillWidth: true
                                        spacing: 3
                                        Image {
                                            source: iconUrl(model.icon)
                                            sourceSize.width: 20
                                            sourceSize.height: 20
                                            Layout.alignment: Qt.AlignHCenter
                                        }
                                        Text { text: model.label; font: Theme.text12Normal; color: Theme.textFaint; Layout.alignment: Qt.AlignHCenter }
                                        Text { text: model.value; font: Theme.text16Normal; color: Theme.textPrimary; Layout.alignment: Qt.AlignHCenter }
                                    }
                                }
                            }
                        }

                        Card {
                            title: qsTr("Araç Konumu")
                            iconSource: iconUrl("pin-green")
                            Layout.preferredHeight: 88

                            RowLayout {
                                spacing: 8
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: 2
                                    Text { text: MockData.coordinates; font: Theme.text14Normal; color: Theme.textBright }
                                    Text { text: MockData.locationName; font: Theme.text13Normal; color: Theme.textMuted }
                                }
                                Rectangle {
                                    width: 36
                                    height: 36
                                    radius: Theme.radiusR8
                                    color: Theme.chipBg
                                    Image {
                                        anchors.centerIn: parent
                                        source: iconUrl("nav-blue")
                                        sourceSize.width: 18
                                        sourceSize.height: 18
                                    }
                                }
                            }
                        }

                        Card {
                            title: qsTr("Sürüş Kontrolleri")
                            Layout.preferredHeight: 238

                            ColumnLayout {
                                spacing: 14
                                RowLayout {
                                    spacing: 10
                                    Rectangle {   // active mode — solid accent
                                        Layout.fillWidth: true
                                        height: 46
                                        radius: Theme.radiusR10
                                        color: Theme.accentBlue
                                        RowLayout {
                                            anchors.centerIn: parent
                                            spacing: 8
                                            Item {   // steering wheel (no white asset — drawn)
                                                implicitWidth: 20
                                                implicitHeight: 20
                                                Shape {
                                                    anchors.fill: parent
                                                    antialiasing: true
                                                    // wheel rim as two semicircle arcs (no PathCircle type)
                                                    PathLine { x: 2; y: 10 }
                                                    PathArc { x: 18; y: 10; xRadius: 8; yRadius: 8
                                                              sweepDirection: ArcSweep.Clockwise; largeArc: false }
                                                    PathArc { x: 2; y: 10; xRadius: 8; yRadius: 8
                                                              sweepDirection: ArcSweep.Clockwise; largeArc: false }
                                                    PathLine { x: 10; y: 10 } PathLine { x: 10; y: 18 }
                                                    PathLine { x: 10; y: 10 } PathLine { x: 3.1; y: 13.5 }
                                                    PathLine { x: 10; y: 10 } PathLine { x: 16.9; y: 13.5 }
                                                    strokeColor: Theme.textPrimary
                                                    strokeWidth: 2
                                                    capStyle: Shape.Round
                                                }
                                            }
                                            Text { text: qsTr("Otonom Mod"); font: Theme.text15Normal; color: Theme.textPrimary }
                                        }
                                    }
                                    Rectangle {   // idle mode — dark, bordered
                                        Layout.fillWidth: true
                                        height: 46
                                        radius: Theme.radiusR10
                                        color: Theme.btnIdleBg
                                        border.color: Theme.borderSubtle
                                        border.width: 1
                                        RowLayout {
                                            anchors.centerIn: parent
                                            spacing: 8
                                            Image {
                                                source: iconUrl("carfront-caminfo")
                                                sourceSize.width: 20
                                                sourceSize.height: 20
                                            }
                                            Text { text: qsTr("Manuel Mod"); font: Theme.text15Normal; color: Theme.textMuted }
                                        }
                                    }
                                }
                                RowLayout {
                                    spacing: 10
                                    Repeater {
                                        model: MockData.assistTiles
                                        Rectangle {
                                            Layout.fillWidth: true
                                            Layout.preferredHeight: 93
                                            radius: Theme.radiusR10
                                            color: Theme.btnDeepBg
                                            border.color: Theme.borderSubtle
                                            border.width: 1
                                            ColumnLayout {
                                                anchors.centerIn: parent
                                                spacing: 8
                                                Image {
                                                    source: iconUrl(model.icon)
                                                    sourceSize.width: 26
                                                    sourceSize.height: 26
                                                    Layout.alignment: Qt.AlignHCenter
                                                }
                                                Text { text: model.label; font: Theme.text12Normal; color: model.labelColor }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
