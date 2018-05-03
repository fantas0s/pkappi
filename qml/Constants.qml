pragma Singleton
import QtQuick 2.9
import QtQuick.Window 2.3

Item {
    readonly property bool landscape: Screen.width > Screen.height ? true : false
    readonly property int fullscreenWidth: Screen.width
    readonly property int fullscreenHeight: Screen.height
    readonly property int menuItemWidth: landscape ? Screen.height / 2 : Screen.width / 2
    readonly property int pixelsOn1cm: 10 * Screen.pixelDensity
    readonly property int fontPixelSizeSmall: 3 * Screen.pixelDensity
    readonly property int fontPixelSizeLarge: 6 * Screen.pixelDensity
    readonly property int fontPixelSizeQuarterScreen: landscape ? Screen.height / 20 : Screen.width / 20
    readonly property int fontPixelSizeOneWord: landscape ? Screen.height / 10 : Screen.width / 10
}
