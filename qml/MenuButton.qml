import QtQuick 2.0
//2021.07.04 zhoulijun
// button with text
Rectangle {
    id: button

    // 这将是默认大小，它与包含的文本大小相同+一些填充
    width: buttonText.width + paddingHorizontal * 2
    height: buttonText.height + paddingVertical * 2
    color: "transparent"
    radius: 10

    // 从文本元素到左右两侧矩形的水平填充
    property int paddingHorizontal: 20
    // 从文本元素到矩形顶部和底部的垂直填充
    property int paddingVertical: 10

    // access the text of the Text component
    property alias buttonText: buttonText
    property alias text: buttonText.text
    property alias label: label
    property bool active: false

    // this handler is called when the button is clicked.
    signal clicked

    Image {
        id: label
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
    }

    Text {
        id: buttonText
        anchors.centerIn: parent
        font.pixelSize: 36
        color: "black"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: button.clicked()
        onPressed: button.opacity = 0.5
        onReleased: button.opacity = 1
    }

}
