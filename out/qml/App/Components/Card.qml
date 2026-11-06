import QtQuick
import QtQuick.Layouts
import App.Style

// Shared panel chrome: rounded dark card with an optional icon + title row.
Item {
    id: root

    property string title: ""
    property url iconSource: undefined
    property color iconColor: Theme.cyanIcon
    // Optional colored dot drawn before the title (e.g. the cyan status dots).
    property color titleDotColor: undefined
    readonly property bool hasIcon: iconSource !== undefined
    readonly property bool showTitleRow: title !== "" || hasIcon
    default property alias content: contentData.data
    // Extra items rendered after the title (legend dots, close buttons...).
    default property alias headerRight: headerRightData.data

    implicitWidth: 370
    implicitHeight: 120

    Rectangle {
        anchors.fill: parent
        radius: Theme.radiusR10
        color: Theme.panelBg
        border.color: Theme.borderSubtle
        border.width: 1
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Theme.space8
        spacing: Theme.space6

        RowLayout {
            visible: root.showTitleRow
            Layout.fillWidth: true
            spacing: Theme.space4

            Rectangle {
                visible: root.titleDotColor !== undefined
                width: 8
                height: 8
                radius: 4
                color: root.titleDotColor
                Layout.alignment: Qt.AlignVCenter
            }

            Image {
                visible: root.hasIcon
                source: root.iconSource
                sourceSize.width: 12
                sourceSize.height: 12
                Layout.preferredWidth: 12
                Layout.preferredHeight: 12
            }

            Text {
                text: root.title
                visible: root.title !== ""
                color: Theme.textPrimary
                font: Theme.text15Normal
            }

            RowLayout {
                id: headerRightData
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignRight
                spacing: Theme.space4
            }
        }

        Item {
            id: contentData
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
