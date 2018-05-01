import QtQuick 2.9
import QtQuick.Controls 2.2
import pkapp.constants 1.0

Page {
    width: Constants.fullscreenWidth
    height: Constants.fullscreenHeight

    header: Label {
        text: qsTr("Valikko")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Grid {
        Image {
            width: Constants.menuItemWidth
            height: Constants.menuItemWidth
            source: "qrc:/images/pussi.svg"
            Label {
                anchors.centerIn: parent
                font.pixelSize: Qt.application.font.pixelSize * 4
                text: "Lorupussi"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: mainStackView.push("qrc:/qml/Lorupussi.qml")
            }
        }
    }
}
