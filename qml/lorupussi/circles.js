var component;
var allCircles = new Array(20);
var currentIdx = 0;

function init()
{
    component = Qt.createComponent("Circle.qml");
    for (var idx = 0 ; idx < allCircles.length ; idx++) {
        allCircles[idx] = null;
    }
}

function deleteAll()
{
    for (var idx = 0 ; idx < allCircles.length ; idx++) {
        if (allCircles[idx] !== null) {
            allCircles[idx].destroy();
            allCircles[idx] = null;
        }
    }
    currentIdx = 0;
}

function create(posX, posY)
{
    if (component.status === Component.Ready)
    {
        var newObject = component.createObject(mptArea);
        newObject.x = posX
        newObject.y = posY
        allCircles[currentIdx] = newObject;
        currentIdx++;
    }
    else if (component.status === Component.Error) {
        console.log("Error: ");
        console.log(component.errorString() );
    }
}

function visibleCircles()
{
    var visibleCircles = 0;
    for (var idx = 0 ; idx < allCircles.length ; idx++) {
        if ((allCircles[idx] !== null) &&
            (allCircles[idx].visible)) {
            visibleCircles++
        }
    }
    return visibleCircles
}

function highlightRandomCircle()
{
    var highlightIndex = Math.floor(Math.random() * visibleCircles())
    for (var idx = 0 ; idx < allCircles.length ; idx++) {
        if ((allCircles[idx] !== null) &&
            (allCircles[idx].visible)) {
            if (idx === highlightIndex)
                allCircles[idx].highlighted = true
            else
                allCircles[idx].highlighted = false
        }
    }
}

function deleteAllButHighlighted()
{
    for (var idx = 0 ; idx < allCircles.length ; idx++) {
        if ((allCircles[idx] !== null) &&
            !allCircles[idx].highlighted) {
            allCircles[idx].destroy();
            allCircles[idx] = null;
        }
    }
    currentIdx = 0;
}
