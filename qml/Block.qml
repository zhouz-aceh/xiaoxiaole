import Felgo 3.0
import QtQuick 2.0
//2021.07.04 zhoulijun
EntityBase {
    id: block
    entityType: "block"

    // 如果在游戏区域外，则隐藏块
    visible: y >= 0

    // 每个方块都知道它的类型和它在场地上的位置
    property int type
    property int row
    property int column

    // 单击块时发出信号
    signal clicked(int row, int column, int type)

    // 单击块时发出信号显示块类型的不同图像
    Image {
        anchors.fill: parent
        source: {
            if (type == 0)
                return "../assets/img/eyu.png"
            else if(type == 1)
                return "../assets/img/cat.png"
            else if (type == 2)
                return "../assets/img/duck.png"
            else if (type == 3)
                return "../assets/img/lion.png"
            else if (type == 4)
                return "../assets/img/sheep.png"
            else
                return "../assets/img/dog.png"
        }
    }

    // 处理块上的点击事件（触发点击信号）
    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked(row, column, type)
    }

    // 移除前淡出块
    NumberAnimation {
        id: fadeOutAnimation
        target: block
        property: "opacity"
        duration: 200
        from: 1.0
        to: 0

        // 淡出完成后移除块
        onStopped: {
            entityManager.removeEntityById(block.entityId)
        }
    }

    // 动画让块掉下来
    NumberAnimation {
        id: fallDownAnimation
        target: block
        property: "y"
    }

    // 等待其他块淡出的计时器
    Timer {
        id: fallDownTimer
        interval: fadeOutAnimation.duration
        repeat: false
        running: false
        onTriggered: {
            fallDownAnimation.start()
        }
    }

    NumberAnimation {
        id: clickWidthAnimation
        target: block
        property: "width"
        duration: 100
        from: gameArea.blockSize
        to: gameArea.blockSize + 3
    }
    NumberAnimation {
        id: clickHeightAnimation
        target: block
        property: "height"
        duration: 100
        from: gameArea.blockSize
        to: gameArea.blockSize + 3
    }

    SoundEffect {
        id: matchSound
        volume: 0.3
        source: "../assets/snd/matchSound.wav"
    }

    //开始淡出/移除块
    function remove() {
        fadeOutAnimation.start()
    }

    // 触发块下落
    function fallDown(distance) {
        //在开始一个新的之前完成上一个
        fallDownAnimation.complete()

        // move with 100 ms per block
        // e.g. moving down 2 blocks takes 200 ms
        fallDownAnimation.duration = 100 * distance
        fallDownAnimation.to = block.y + distance * block.height

        // wait for removal of other blocks before falling down等待其他积木拆除后再坠落
        fallDownTimer.start()
    }

    function clickAnimation() {
        clickWidthAnimation.start()
        clickHeightAnimation.start()
    }

    function matchSoundPlay() {
        matchSound.play()
    }
}
