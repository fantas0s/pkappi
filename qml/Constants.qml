pragma Singleton
import QtQuick 2.9
import QtQuick.Window 2.3

Item {
    readonly property bool landscape: Screen.width > Screen.height ? true : false
    readonly property int fullscreenWidth: Screen.width
    readonly property int fullscreenHeight: Screen.height
    readonly property int menuItemWidth: landscape ? Screen.height / 2 : Screen.width / 2
    readonly property int pixelsOn1cm: 10 * Screen.pixelDensity
}
