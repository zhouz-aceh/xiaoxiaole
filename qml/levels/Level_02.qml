import Felgo 3.0
import QtQuick 2.0
import "../.."
import ".."

Item {
    id: scene

    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 320
    height: 480

    // property to hold game score
    property int score
    property int types: 3

    // for dynamic creation of entities
    EntityManager {
      id: entityManager
      entityContainer: gameArea
    }

    // background image
    BackgroundImage {
        source: "../../assets/img/background.png"
        anchors.centerIn: scene.Center
    }

    // back button to leave scene
    MenuButton {
        label.height: 30
        label.width: 60
        label.source: "../../assets/img/exit.png"
        color: "transparent"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 400
        anchors.rightMargin:30
        onClicked: match3GameScene.backButtonPressed()
    }

    // display level number
    Text {
        // set font
        font.family: gameFont.name
        font.pixelSize: 15
        color: "white"
        text: "Level 2"

        // set position
        anchors.horizontalCenter: parent.horizontalCenter
        y: 415
    }

    // display score
    Text {
        // set font
        font.family: gameFont.name
        font.pixelSize: 15
        color: "white"
        text: scene.score + " / " + gameArea.goal

        // set position
        anchors.horizontalCenter: parent.horizontalCenter
        y: 446
    }

    // game area holds game field with blocks
    GameArea {
        id: gameArea
        goal: 400
        anchors.horizontalCenter: scene.horizontalCenter
        blockSize: 30
        y: 20
        onGameClearance: gameClearanceWindow.show()
        onGameOver: gameOverWindow.show()
    }

    // configure gameclearance window
    GameClearanceWindow {
        id: gameClearanceWindow
        y: 90
        opacity: 0
        anchors.horizontalCenter: scene.horizontalCenter
        onNextLevelClicked: scene.nextLevel()
    }

    // configure gameover window
    GameOverWindow {
        id: gameOverWindow
        y: 90
        opacity: 0 // by default the window is hidden
        anchors.horizontalCenter: scene.horizontalCenter
        onNewGameClicked: scene.startGame()
    }

    Component.onCompleted: startGame()

    // initialize game
    function startGame() {
        gameOverWindow.hide()
        gameArea.initializeField(types)
        scene.score = 0
    }

    // next level
    function nextLevel() {
        gameClearanceWindow.hide()
        selectGameScene.levelPressed("Level_03.qml")
    }
}
