import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.VirtualKeyboard 2.2
import pkapp.constants 1.0

ApplicationWindow {
    id: window
    Material.theme: Material.Dark
    visible: true
    width: Constants.fullscreenWidth
    height: Constants.fullscreenHeight
    title: qsTr("Tabs")

    StackView {
        id: mainStackView
        anchors.fill: parent
        initialItem: "qrc:/qml/Valikko.qml"
        pushEnter: Transition {
            ScaleAnimator {
                from: 0
                to: 1
            }
        }
        pushExit: Transition {
            XAnimator {
                from: 0
                to: 0
            }
        }
    }
}
