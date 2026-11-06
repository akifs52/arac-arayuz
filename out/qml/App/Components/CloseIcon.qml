import QtQuick
import App.Style

// Small "×" used to dismiss a panel in the reference.
Item {
    id: root

    implicitWidth: 12
    implicitHeight: 12

    Shape {
        anchors.fill: parent
        antialiasing: true
        PathLine { x: 0; y: 0 }
        PathLine { x: 12; y: 12 }
        PathLine { x: 12; y: 0 }
        PathLine { x: 0; y: 12 }
        strokeColor: Theme.textFaint
        strokeWidth: 1.5
    }
}
