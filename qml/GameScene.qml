import Felgo 3.0
import QtQuick 2.0
import ".."
import"./levels"
//2021.07.04 zhoulijun
// scene with the actual game

SceneBase {
    id: gameScene

    // filename of the current level
    property string activeLevelFileName
    // currently loaded level
    property var activeLevel

    property alias loader: loader

    // set the name of the current level, this will cause the Loader to load the corresponding level
    function setLevel(fileName) {
        activeLevelFileName = fileName
    }

    // load levels at runtime
    Loader {
        id: loader
        source: activeLevelFileName ? "./levels/" + activeLevelFileName : ""
        onLoaded: {
            // store the loaded level as activeLevel for easier access
            activeLevel = item
        }
    }
}
