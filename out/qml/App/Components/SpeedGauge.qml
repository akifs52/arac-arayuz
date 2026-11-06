import QtQuick
import App.Style

// 270° speed dial: dark track from bottom-left through the top to bottom-right,
// cyan value arc for `value / maxSpeed`. The reference dial is scaled to the
// posted limit (68 of 70 km/s ≈ nearly full), so Main.qml passes speedLimit.
Item {
    id: root

    property real value: 0
    property real maxSpeed: 120
    readonly property real fraction: Math.min(Math.max(value / maxSpeed, 0), 1)

    implicitWidth: 186
    implicitHeight: 186

    // Screen angles are clockwise from east; y grows downward.
    function pt(angleDeg, radius) {
        var a = angleDeg * Math.PI / 180
        return [width / 2 + radius * Math.cos(a), height / 2 + radius * Math.sin(a)]
    }

    readonly property real ringR: Math.min(width, height) / 2 - 6   // room for the stroke

    Shape {
        anchors.fill: parent
        antialiasing: true
        PathLine { x: pt(135, root.ringR)[0]; y: pt(135, root.ringR)[1] }
        PathArc {
            x: pt(45, root.ringR)[0]
            y: pt(45, root.ringR)[1]
            xRadius: root.ringR
            yRadius: root.ringR
            sweepDirection: ArcSweep.Clockwise
            largeArc: true          // 270° > 180°
            strokeColor: Theme.gaugeTrack
            strokeWidth: 10
            capStyle: Shape.Round
        }
    }

    Shape {
        anchors.fill: parent
        antialiasing: true
        visible: root.fraction > 0.001
        PathLine { x: pt(135, root.ringR)[0]; y: pt(135, root.ringR)[1] }
        PathArc {
            x: pt(135 + 270 * fraction, root.ringR)[0]
            y: pt(135 + 270 * fraction, root.ringR)[1]
            xRadius: root.ringR
            yRadius: root.ringR
            sweepDirection: ArcSweep.Clockwise
            largeArc: 270 * fraction > 180
            strokeColor: Theme.gaugeArc
            strokeWidth: 10
            capStyle: Shape.Round
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 0
        Text {
            text: String(Math.round(root.value))
            font: Theme.text49Normal
            color: Theme.textPrimary
            Layout.alignment: Qt.AlignHCenter
        }
        Text {
            text: qsTr("km/s")
            font: Theme.text16Normal
            color: Theme.gaugeUnit
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
