import Felgo 3.0
import QtQuick 2.0
//2021.07.04 zhoulijun
Item {
    id: gameClearanceWindow

    width: 232
    height: 160

    // hide when opacity = 0
    visible: opacity > 0

    // the item receives mouse and keyboard events when opacity = 1
    enabled: opacity == 1

    // signal when next level button is clicked
    signal nextLevelClicked()

    // let the gameover-window fade in and out
    Behavior on opacity {
        NumberAnimation { duration: 400 }
    }

    Image {
        source: "../assets/img/GameOver.png"
        anchors.fill: parent
    }

    // display score
    Text {
        // set font
        font.family: gameFont.name
        font.pixelSize: 30
        color: "#1a1a1a"
        text: scene.score

        // set position
        anchors.horizontalCenter: parent.horizontalCenter
        y: 72
    }

    // play next level button
    Text {
        // set font
        font.family: gameFont.name

        font.pixelSize: 15
        color: "red"
        text: "next level"

        // set position
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15

        // signal click event
        MouseArea {
            anchors.fill: parent
            onClicked: gameClearanceWindow.nextLevelClicked()
        }

        // this animation sequence changes the color of text between red and orange infinitely
        SequentialAnimation on color {
            loops: Animation.Infinite
            PropertyAnimation {
                to: "#ff8800"
                duration: 1000 // 1 second for fade to orange
            }
            PropertyAnimation {
                to: "red"
                duration: 1000 // 1 second for fade to red
            }
        }
    }

    // shows the window
    function show() {
        gameClearanceWindow.opacity = 1
    }

    // hides the window
    function hide() {
        gameClearanceWindow.opacity = 0
    }
}
