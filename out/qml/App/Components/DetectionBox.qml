import QtQuick
import App.Style

// One object-detection overlay on the camera feed. The label pill straddles
// the box's top edge, tinted with the same color as the border.
Rectangle {
    id: root

    property string label: ""
    property color boxColor: Theme.accentBlue

    radius: Theme.radiusR6
    color: "transparent"
    border.color: root.boxColor
    border.width: 2

    Rectangle {
        anchors.left: parent.left
        anchors.verticalCenter: parent.top   // pill centered on the top edge
        height: 20
        width: labelPill.implicitWidth + Theme.space6 * 2
        radius: Theme.radiusR4
        color: root.boxColor

        Text {
            id: labelPill
            anchors.centerIn: parent
            text: root.label
            font: Theme.text12Normal
            color: Theme.textPrimary
        }
    }
}
