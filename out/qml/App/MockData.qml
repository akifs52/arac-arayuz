pragma Singleton
import QtQuick
import App.Style

// Mock data for the AutoPilot Pro dashboard. In production this would come
// from vehicle telemetry; every repeated UI element is a delegate over one of
// these models.
QtObject {
    id: root

    // ---- sidebar navigation -------------------------------------------
    readonly property var navItems: [
        { icon: "home",       label: qsTr("Ana Panel"),          active: true  },
        { icon: "video",      label: qsTr("Kamera Görüntüsü"),   active: false },
        { icon: "mappin",     label: qsTr("Harita ve Navigasyon"), active: false },
        { icon: "steering",   label: qsTr("Sürüş Asistanı"),     active: false },
        { icon: "gauge",      label: qsTr("Araç Durumu"),        active: false },
        { icon: "zap",        label: qsTr("Enerji Yönetimi"),    active: false },
        { icon: "database",   label: qsTr("Veri Kayıtları"),     active: false },
        { icon: "settings",   label: qsTr("Ayarlar"),            active: false }
    ]

    // ---- camera detections (box in panel-local px; label pill sits above) --
    readonly property var detections: [
        { label: qsTr("Araç 18.9 m"),     x: 120, y: 268, w: 112, h: 140, color: Theme.accentBlue },
        { label: qsTr("Araç 12.4 m"),     x: 316, y: 270, w: 104, h: 132, color: Theme.accentBlue },
        { label: qsTr("Otobüs 32.6 m"),   x: 502, y: 228, w: 108, h: 150, color: Theme.green },
        { label: qsTr("Bisikletçi 6.3 m"), x: 676, y: 262, w: 88,  h: 120, color: Theme.chartOrange },
        { label: qsTr("Yaya 24.8 m"),     x: 850, y: 250, w: 80,  h: 124, color: Theme.detectPurple }
    ]

    // ---- object counters ----------------------------------------------
    readonly property var objectCounts: [
        { icon: "car-blue",       label: qsTr("Araç"),      count: 12 },
        { icon: "user-purple",    label: qsTr("Yaya"),      count: 3  },
        { icon: "bicycle-orange", label: qsTr("Bisikletçi"), count: 2 },
        { icon: "scan-gray",      label: qsTr("Diğer"),     count: 1  }
    ]

    // ---- motor temperatures -------------------------------------------
    readonly property var motorTemps: [
        { icon: "thermo-cyan",   label: qsTr("Ön Motor"),   value: qsTr("42°C") },
        { icon: "thermo-cyan",   label: qsTr("Arka Motor"), value: qsTr("38°C") },
        { icon: "battery-cyan",  label: qsTr("Batarya"),    value: qsTr("35°C") }
    ]

    // ---- driver-assist tiles ------------------------------------------
    readonly property var assistTiles: [
        { icon: "route-green",     label: qsTr("Şerit Takip"),   labelColor: Theme.greenBright },
        { icon: "carfront-blue",   label: qsTr("Trafik Asistanı"), labelColor: Theme.textSoft },
        { icon: "parking-gray",    label: qsTr("Park Asistanı"),  labelColor: Theme.textMuted }
    ]

    // ---- driving data chart (20 samples, 14:32 → 14:37) ----------------
    readonly property var speedSeries: [62, 64, 61, 66, 68, 65, 69, 71, 68, 66,
                                        67, 70, 72, 69, 67, 68, 70, 68, 69, 68]
    readonly property var rpmSeries: [2400, 2500, 2300, 2700, 2900, 2600, 3100, 3300,
                                      2900, 2700, 2800, 3200, 3400, 3000, 2800, 2900,
                                      3100, 2900, 3000, 2950]
    readonly property var batterySeries: [79, 79, 78, 78, 78, 78, 78, 78, 78, 78,
                                          78, 78, 78, 78, 78, 78, 78, 78, 78, 78]
    readonly property var chartTimes: [qsTr("14:32"), qsTr("14:33"), qsTr("14:34"),
                                       qsTr("14:35"), qsTr("14:36"), qsTr("14:37")]

    // ---- telemetry values ---------------------------------------------
    readonly property int currentSpeed: 68
    readonly property int targetSpeed: 70
    readonly property int speedLimit: 70
    readonly property real batteryPercent: 78
    readonly property string remainingRange: qsTr("362 km")
    readonly property string estimatedTime: qsTr("4 sa 12 dk")
    readonly property string coordinates: "41.0082° N  28.9784° E"
    readonly property string locationName: qsTr("İstanbul, Türkiye")
    readonly property string vehicleModel: qsTr("Tesla Model 3")
    readonly property string vin: "VIN: SYJ3ETEA7NF123456"

    // chart legend (dot color + label)
    readonly property var chartLegend: [
        { color: Theme.accentBlue,   label: qsTr("Hız") },
        { color: Theme.chartOrange,  label: qsTr("RPM") },
        { color: Theme.greenBright,  label: qsTr("Batarya") }
    ]
}
