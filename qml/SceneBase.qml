import Felgo 3.0
import QtQuick 2.0
//2021.07.04 zhoulijun
// main base for all scenes(主基地
Scene {
    id: sceneBase
    width: 320
    height: 480

    // by default, set the opacity(不透明度) to 0 - this is changed from the main.qml with PropertyChanges
    opacity: 0

    // 透明度大于0可见
    visible: opacity > 0

    // 如果场景不可见，我们就禁用它。
    enabled: visible

    // 不透明度的每一个变化都将通过动画来完成
    Behavior on opacity {
        NumberAnimation {property: "opacity"; easing.type: Easing.InOutQuad}
    }
}
