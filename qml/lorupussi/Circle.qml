import QtQuick 2.9
import pkapp.constants 1.0

Item {
    id: circleAnchor
    property bool highlighted: false
    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: -(size/2)
        anchors.left: parent.left
        anchors.leftMargin: -(size/2)
        property int size: circleAnchor.highlighted ? Constants.pixelsOn1cm * 2 : Constants.pixelsOn1cm * 1.5
        width: size
        height: size
        radius: size/2
        color: circleAnchor.highlighted ? "red" : "white"
        visible: circleAnchor.visible
    }
}
