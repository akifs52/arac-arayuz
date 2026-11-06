import QtQuick
import App.Style

// Multi-series line chart on a shared 0–120 axis. Each series is divided by
// its scale so all three fit: speed raw (÷1), RPM ÷50, battery % ÷2.5 — the
// same trick the reference uses to draw 3000 rpm and 78% on one dial.
Item {
    id: root

    property var seriesData: []          // list of number arrays (same length)
    property var scales: [1, 50, 2.5]
    property var times: []               // x tick labels
    property real yMax: 120
    readonly property var gridValues: [0, 30, 60, 90, 120]
    readonly property var seriesColors: [Theme.accentBlue, Theme.chartOrange, Theme.greenBright]

    function plotLeft() { return 34 }
    function plotTop() { return 8 }
    function plotW() { return Math.max(width - 34 - 10, 1) }
    function plotH() { return Math.max(height - 8 - 22, 1) }

    // horizontal gridlines + y labels
    Repeater {
        model: root.gridValues
        delegate: Item {
            y: root.plotTop() + root.plotH() * (1 - modelData / root.yMax)
            height: 1
            Rectangle {
                anchors.left: parent.left
                width: root.plotW()
                height: 1
                color: Theme.borderSubtle
            }
            Text {
                text: String(modelData)
                font: Theme.text12Normal
                color: Theme.axisLabel
                x: root.plotLeft() - 6
                y: -7
                width: 24
                horizontalAlignment: Text.AlignRight
            }
        }
    }

    // vertical gridlines + x labels
    Repeater {
        model: root.times.length ? root.times : []
        delegate: Item {
            readonly property real tx: root.plotLeft() + index * root.plotW() / Math.max(root.times.length - 1, 1)
            Rectangle {
                x: tx
                y: root.plotTop()
                width: 1
                height: root.plotH()
                color: Theme.borderSubtle
            }
            Text {
                text: modelData
                font: Theme.text12Normal
                color: Theme.axisLabel
                x: tx - 20
                y: root.plotTop() + root.plotH() + 5
                width: 40
                horizontalAlignment: Text.AlignCenter
            }
        }
    }

    // series polylines
    Repeater {
        model: root.seriesData.length
        delegate: Shape {
            antialiasing: true
            PathPolyline {
                points: root.polyPoints(index)
                strokeColor: root.seriesColors[index]
                strokeWidth: 2
                capStyle: Shape.Round
            }
        }
    }

    function polyPoints(seriesIndex) {
        var data = root.seriesData[seriesIndex]
        if (!data || data.length < 2) return ""
        var scale = root.scales[seriesIndex] || 1
        var n = data.length - 1
        var pts = []
        for (var i = 0; i <= n; ++i) {
            var x = root.plotLeft() + i * root.plotW() / n
            var y = root.plotTop() + root.plotH() * (1 - data[i] / scale / root.yMax)
            pts.push(x.toFixed(2) + "," + y.toFixed(2))
        }
        return pts.join(" ")
    }
}
