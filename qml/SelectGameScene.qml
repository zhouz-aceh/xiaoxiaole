import Felgo 3.0
import QtQuick 2.0
import "./levels"
//2021.07.04 zhoulijun
// scene with the gamelevel selection

SceneBase {
    id: selectGameScene

    // signal indicating that a game has been selected

    signal levelPressed(string selectedLevel)
    // background
    Image {
        z: -2
        id:background
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
        onClicked: selectGameScene.backButtonPressed()
    }

    // header
    Text {
        id: headerText
        text: "Levels"
        color: "white"
        font.family: gameFont.name
        font.pixelSize: 36
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 100
    }
    // tutorial hint
    Text {
        id: tutorial
        text: "Start"
        color: "#AFDF99"
        font.family: gameFont.name
        font.pixelSize: 16
        anchors {
            top: parent.top
            topMargin: 160
            left: parent.left
            leftMargin: 29
        }
    }

    // show selectable levels
    Grid {
        anchors.centerIn: parent
        spacing: 2
        columns: 5

        // repeater adds 10 levels to grid
        Repeater {
            model: 10
            delegate: Rectangle { // delegate describes the structure for each level item
                width: 52
                height: 52
                radius: 12
                color: "#AFD788"

                Rectangle {
                    width: 44
                    height: 44
                    anchors.centerIn: parent
                    radius: 11
                    color: "white"

                    Rectangle {
                        width: 40
                        height: 40
                        anchors.centerIn: parent
                        radius: 10
                        color: "#AFD788"

                        MenuButton {
                            property int level: index + 1 // index holds values from 0 to 9 (we set our repeater model to 10)
                            text: level
                            width: 36
                            height: 36
                            anchors.centerIn: parent
                            buttonText.color: "white"
                            buttonText.font.family: gameFont.name
                            buttonText.font.pixelSize: 24
                            onClicked: {
                                var levelFile = "Level_"+level+".qml";
                                if(level < 10)
                                  levelFile = "Level_0"+level+".qml";
                                levelPressed(levelFile) // e.g. Level_01.qml, Level_02.qml, ... Level_10.qml
                            }
                        }
                    }
                }
            }
        }
    }
}

