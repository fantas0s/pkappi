import QtQuick 2.9
import QtQuick.Controls 2.2
import "qrc:/qml/lorupussi/circles.js" as CirclesJs
import pkapp.constants 1.0

Page {
    id: lorupussiPage
    width: Constants.fullscreenWidth
    height: Constants.fullscreenHeight
    Component.onCompleted: CirclesJs.init()
    property bool lotteryOngoing: false

    header: Label {
        id: headerBar
        text: qsTr("Kuka saa, kuka saa, lorupussiin kurkistaa?")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Image {
        source: "qrc:/images/well.jpg"
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
    }
    Label {
        id: countDownLabel
        text: startLotteryTimer.remaining
        anchors.centerIn: parent
        font.pixelSize: Qt.application.font.pixelSize * 8
    }

    Label {
        text: "CC BY-SA 4.0 Rijksdienst voor het Cultureel Erfgoed"
        font.pixelSize: Qt.application.font.pixelSize
        anchors.bottom: parent.bottom
        anchors.bottomMargin: headerBar.height
        anchors.right: parent.right
    }
    MultiPointTouchArea {
        id: mptArea
        function refreshCircles() {
            if (lorupussiPage.lotteryOngoing === false) {
                startLotteryTimer.remaining = 5
                startLotteryTimer.restart()
                CirclesJs.deleteAll()
                for (var idx = 0 ; idx < mptArea.touchPoints.length ; idx++) {
                    if (mptArea.touchPoints[idx].pressed)
                        CirclesJs.create(mptArea.touchPoints[idx].x, mptArea.touchPoints[idx].y)
                }
            } else {
                /* Do not update during lottery */
            }
        }
        touchPoints: [
            TouchPoint {},
            TouchPoint {},
            TouchPoint {},
            TouchPoint {},
            TouchPoint {},
            TouchPoint {},
            TouchPoint {},
            TouchPoint {},
            TouchPoint {},
            TouchPoint {}
        ]
        anchors.fill: parent
        onPressed: refreshCircles()
        onReleased: refreshCircles()
    }
    Timer {
        id: startLotteryTimer
        property int remaining: 5
        interval: 1000
        running: true
        onTriggered: {
            remaining--;
            if (remaining === 0) {
                running = false
                lorupussiPage.lotteryOngoing = true
                lotteryTimer.running = true
            } else {
                running = true
            }
        }
    }
    Timer {
        id: lotteryTimer
        property int remaining: 10
        running: false
        interval: 500
        onTriggered: {
            CirclesJs.highlightRandomCircle()
            remaining--;
            if (remaining === 0) {
                running = false
                CirclesJs.deleteAllButHighlighted()
            } else {
                running = true
            }
        }
    }
}
