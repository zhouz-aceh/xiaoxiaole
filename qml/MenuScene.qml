import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.0
//2021.07.04 zhoulijun
// scene with the main menu

SceneBase {
    id: menuScene

    //指示应显示选定游戏场景的信号
    signal gamePressed
    signal settingsPressed
    signal creditsPressed

    property alias ambienceMusic: ambienceMusic

    // play background music
    BackgroundMusic {
        loops: SoundEffect.Infinite
        volume: 0.35
        id: ambienceMusic
        source: "../assets/snd/BG.mp3"
    }

    // timer plays the background music
    Timer {
        id: timerMusic
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            ambienceMusic.play()
            running = false
        }
    }

    // background
    Image {
        z: -2
        id: background
        source: "../assets/img/MenuBG.png"

        // use this if the image should be centered, which is the most common case

        anchors.centerIn: parent
    }

    // switch to level selection scene
    MenuButton {
        id: menuButton1
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 345
        anchors.leftMargin: 100
        text: "Play"
        onClicked: gamePressed()
        color: "transparent"
        buttonText.color: "white"
        buttonText.opacity: 1
        buttonText.font.pixelSize: 25
        buttonText.font.family: gameFont.name
    }

    // switch to settings scene
    MenuButton {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 400
        anchors.leftMargin: 80
        text: "Settings"
        onClicked: settingsPressed()
        color: "transparent"
        buttonText.color: "white"
        buttonText.opacity: 1
        buttonText.font.pixelSize: 20
        buttonText.font.family: gameFont.name
    }
    // switch to credits scene
    MenuButton {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 290
        anchors.leftMargin: 100
        text: "Rules"
        onClicked: creditsPressed()
        color: "transparent"
        buttonText.color: "white"
        buttonText.opacity: 1
        buttonText.font.pixelSize: 20
        buttonText.font.family: gameFont.name
    }


}
