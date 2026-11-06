import QtQuick
import QtQuick.Layouts
import App.Style

// One row of the left navigation; `active` paints the blue pill background.
Item {
    id: root

    property string label: ""
    property url iconSource: undefined
    property bool active: false

    implicitWidth: 250
    implicitHeight: Theme.space15   // 40px rows in the reference

    Rectangle {
        anchors.fill: parent
        visible: root.active
        radius: Theme.radiusR10
        color: Theme.navActiveBg
    }

    RowLayout {
        anchors.centerIn: parent
        spacing: Theme.space6

        Image {
            source: root.iconSource
            sourceSize.width: 20
            sourceSize.height: 20
            Layout.preferredWidth: 20
            Layout.preferredHeight: 20
        }

        Text {
            text: root.label
            font: Theme.text15Normal
            color: root.active ? Theme.textPrimary : Theme.navLabelAlt
        }
    }
}
