import QtQuick 2.9
import QtQuick.Controls 2.2
import "qrc:/qml/lorupussi/circles.js" as CirclesJs
import pkapp.constants 1.0

Page {
    id: lorupussiPage
    width: Constants.fullscreenWidth
    height: Constants.fullscreenHeight
    Component.onCompleted: CirclesJs.init()
    property int loruIteration: 0
    property var pussiTexts: ["Kuka",
        "saa",
        "kuka",
        "saa",
        "lorupussiin",
        "kurkistaa",
        "tillin",
        "tallin",
        "tömpsis"]
    property var timeMultipliers: [1, 1, 1, 1, 2, 2, 1, 1, 2]

    header: Label {
        id: headerBar
        text: qsTr("Lorupussi")
        font.pixelSize: Constants.fontPixelSizeLarge
        padding: 10
    }

    Image {
        source: "qrc:/images/well.jpg"
        fillMode: Image.PreserveAspectCrop
        anchors.fill: parent
    }
    Label {
        id: countDownLabel
        text: waitFingersTimer.remaining
        anchors.centerIn: parent
        visible: false
        font.pixelSize: Constants.fontPixelSizeOneWord
    }
    Label {
        id: kukasaaLabel
        text: lorupussiPage.pussiTexts[lorupussiPage.loruIteration]
        anchors.centerIn: parent
        visible: false
        font.pixelSize: Constants.fontPixelSizeOneWord
        color: "#FF8800"
        z: 10
    }

    Label {
        text: "CC BY-SA 4.0 Rijksdienst voor het Cultureel Erfgoed"
        font.pixelSize: Constants.fontPixelSizeSmall
        anchors.bottom: parent.bottom
        anchors.bottomMargin: headerBar.height
        anchors.right: parent.right
    }
    MultiPointTouchArea {
        id: mptArea
        function refreshCircles() {
            if (lorupussiPage.state === "waitingFingers") {
                waitFingersTimer.remaining = 5
                waitFingersTimer.restart()
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
        onPressed: {
            if (lorupussiPage.state === "")
                lorupussiPage.state = "waitingFingers"
            if (lorupussiPage.state === "waitingFingers")
                refreshCircles()
        }
        onReleased: {
            if (lorupussiPage.state === "waitingFingers") {
                var touches = 0
                for (var idx = 0 ; idx < mptArea.touchPoints.length ; idx++) {
                    if (mptArea.touchPoints[idx].pressed)
                        touches++
                }
                refreshCircles()
                if (touches === 0)
                    lorupussiPage.state = ""
            }
        }
    }
    Timer {
        id: waitFingersTimer
        property int remaining: 5
        interval: 1000
        running: false
        onTriggered: {
            remaining--;
            if (remaining === 0) {
                running = false
                lorupussiPage.state = "lottery"
                CirclesJs.highlightRandomCircle()
            } else {
                running = true
            }
        }
    }
    Timer {
        id: lotteryTimer
        property int internalIteration: 0
        running: false
        interval: 800
        onTriggered: {
            internalIteration++
            if (internalIteration >= lorupussiPage.timeMultipliers[lorupussiPage.loruIteration]) {
                internalIteration = 0;
                loruIteration++;
            }
            if (loruIteration < lorupussiPage.timeMultipliers.length) {
                CirclesJs.highlightRandomCircle()
                running = true
            } else {
                CirclesJs.deleteAllButHighlighted()
                lorupussiPage.state = "selected"
            }
        }
    }

    states: [
        State {
            name: "waitingFingers"
            PropertyChanges { target: waitFingersTimer; running: true }
            PropertyChanges { target: lotteryTimer; running: false }
            PropertyChanges { target: countDownLabel; visible: true }
        },
        State {
            name: "lottery"
            PropertyChanges { target: lotteryTimer; running: true }
            PropertyChanges { target: waitFingersTimer; running: false }
            PropertyChanges { target: countDownLabel; visible: false }
            PropertyChanges { target: kukasaaLabel; visible: true }
        },
        State {
            name: "selected"
            PropertyChanges { target: lotteryTimer; running: false }
            PropertyChanges { target: kukasaaLabel; visible: false }
        }
    ]
}
