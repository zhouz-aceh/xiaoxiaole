import Felgo 3.0
import QtQuick 2.0
//2021.07.04 zhoulijun
SceneBase {
    id:settingScene

    // background
    Image {
        z: -2
        id: background
        source: "../assets/img/SettingBG.png"


        anchors.centerIn: parent
    }

    // back button to leave scene
    MenuButton {
        label.height: 30
        label.width: 60
        label.source: "../assets/img/back.png"
        color: "transparent"
        z: 10
        anchors.right: gameWindowAnchorItem.right
        anchors.rightMargin: 20
        anchors.top: gameWindowAnchorItem.top
        onClicked: settingScene.backButtonPressed()
    }


    Column {
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 40
        spacing: 20

        // header settings
        Text {
            font.family: gameFont.name
            font.pixelSize: 36
            text: "Settings"
            color: "black"
        }

        // header background music
        Text {
            font.family: settingsFont.name
            font.pixelSize: 24
            text: "Background Music"
            color: "black"
        }

        // header sound effects
        Text {
            font.family: settingsFont.name
            font.pixelSize: 24
            text: "Sound Effects"
            color: "black"
        }
    }

    Column {
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 133
        spacing: 18

        // button to turn the music on and off
        MenuButton {
            width: 60
            height: 30
            label.source: active ? "../assets/img/SwitchOff.png" : "../assets/img/SwitchOn.png"
            active: ! settings.musicEnabled
            opacity: 1
            onClicked:  {
                settings.musicEnabled ^= true
            }
        }

        // button to turn the sound effects on and off
        MenuButton {
            width: 60
            height: 30
            label.source: active ? "../assets/img/SwitchOff.png" : "../assets/img/SwitchOn.png"
            active: ! settings.soundEnabled
            opacity: 1
            onClicked: {
                settings.soundEnabled ^= true
            }
        }
    }
}
