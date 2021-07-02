import Felgo 3.0
import QtQuick 2.0
//2021.07.04 zhoulijun
SceneBase {
    id:creditsScene

    // background
    Image {
        z: -2
        id: background
        source: "../assets/img/SettingBG.png"

        // use this if the image should be centered, which is the most common case
        // if the image should be aligned at the bottom, probably the whole scene should be aligned at the bottom, and the image should be shifted up by the delta between the imagesSize and the scene.y!
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
        onClicked: creditsScene.backButtonPressed()
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
            font.pixelSize: 30
            text: "Game Rules"
            color: "black"
        }

        // header background music
        Text {
            font.family: settingsFont.name
            font.pixelSize: 26
            text: "First:"
            color: "black"
        }
        Text {
            font.family: settingsFont.name
            font.pixelSize: 20
            text: "Click more than three of the same ones"
            color: "grey"
        }
        Text {
            font.family: settingsFont.name
            font.pixelSize: 20
            text: "to eliminate them."
            color: "grey"
        }
        Text {
            font.family: settingsFont.name
            font.pixelSize: 24
            text: "Second:"
            color: "black"
        }
        Text {
            font.family: settingsFont.name
            font.pixelSize: 20
            text: "As the level becomes higher, there will"
            color: "grey"
        }
        Text {
            font.family: settingsFont.name
            font.pixelSize: 20
            text: "be more animals and higher score limit."
            color: "grey"
        }



}
}
