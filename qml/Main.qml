import Felgo 3.0
import QtQuick 2.0
import"./levels"

//2021.07.04 zhoulijun
GameWindow {
    id: gameWindow


    screenWidth: 640
    screenHeight: 960

    // 用于动态创建实体
    EntityManager {
        id: entityManager
        entityContainer: match3GameScene
    }


    // ttf字体的自定义字体加载
    FontLoader {
        id: gameFont
        source: "../assets/fonts/akaDylan Plain.ttf"
    }
    FontLoader {
        id: settingsFont
        source: "../assets/fonts/bubblegum.ttf"
    }

    // menu scene
    MenuScene {
        id: menuScene
        //收听现场按钮信号，并根据其改变状态
        onGamePressed: gameWindow.state = "selectGame"
        onSettingsPressed: gameWindow.state = "settings"
         onCreditsPressed: gameWindow.state = "credits"
    }



    // scene for selecting levels
    SelectGameScene {
       id: selectGameScene
        onLevelPressed: {
            // selectedLevel是levelPressed信号的参数
            match3GameScene.setLevel(selectedLevel)
            gameWindow.state = "match3Game"
        }
        onBackButtonPressed: gameWindow.state = "menu"
    }

    // credits scene
    SettingScene {
        id: settingScene
        onBackButtonPressed: gameWindow.state = "menu"

    }

    // game scene to play xiaoxiaole
    GameScene {
        id: match3GameScene
        onBackButtonPressed: {
            gameWindow.state = "selectLevel"

        }

    }
    //  scene to  credits
        CreditsScene {
            id: creditsScene
            onBackButtonPressed: gameWindow.state = "menu"

        }



    // menuScene是我们的第一个场景，所以首先将状态设置为menu
    state: "menu"
    activeScene: menuScene

    // 状态机在更改状态时会注意反转属性更改，例如将不透明度更改回0
    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: menuScene}
        },
       State {
            name: "selectGame"
            PropertyChanges {target: selectGameScene; opacity: 1}
           PropertyChanges {target: gameWindow; activeScene: selectGameScene}
        },
        State {
            name: "selectLevel"
            PropertyChanges {target: selectGameScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: selectGameScene}
        },
        State {
            name: "settings"
            PropertyChanges {target: settingScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: settingScene}
        },
        State {
            name: "match3Game"
            PropertyChanges {target: match3GameScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: match3GameScene}
       },
        State {
            name: "credits"
            PropertyChanges {target: creditsScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: creditsScene}
        }

    ]
}
