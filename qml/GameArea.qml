import Felgo 3.0
import QtQuick 2.0
import ".."
import"levels"
//2021.07.04 zhoulijun
Item {
    id: gameArea

    // 应为块大小的倍数
    // 游戏场地是8列12行大
    width: blockSize * 8
    height: blockSize * 12

    // properties for game area configuration配置
    property double blockSize
    property int rows: Math.floor(height / blockSize)
    property int columns: Math.floor(width / blockSize)

    // array for handling game field游戏场阵
    property var field: []

    //target score
    property int goal

    // properties for increasing game difficulty
    property int maxTypes
    property int clicks

    // game clearance signal
    signal gameClearance()

    // game over signal
    signal gameOver()

// calculate field index-------------------------计算字段索引
    function index(row, column) {
        return row * columns + column
    }

// fill game field with blocks---------------------用积木填满游戏场地
    function initializeField(types) {
        // reset difficulty
        gameArea.clicks = 0
        gameArea.maxTypes = types

        // clear field
        clearField()

        // fill field
        for(var i = 0; i < rows; i++) {
            for(var j = 0; j < columns; j++) {
                gameArea.field[index(i, j)] = createBlock(i, j)
            }
        }
    }

    // clear game field----------------------
    function clearField() {
        // remove entities
        for(var i = 0; i < gameArea.field.length; i++) {
            var block = gameArea.field[i]
            if(block !== null)  {
                entityManager.removeEntityById(block.entityId)
            }
        }
        gameArea.field = []
    }

    // create a new block at specific position-----------------------在特定位置创建新块
    function createBlock(row, column) {
        //  配置块
        var entityProperties = {
            width: blockSize,
            height: blockSize,
            x: column * blockSize,
            y: row * blockSize,

            type: Math.floor(Math.random() * gameArea.maxTypes), // 随机类型
            row: row,
            column: column
        }

        // add block to game area-------------------
        var id = entityManager.createEntityFromUrlWithProperties(
                    Qt.resolvedUrl("Block.qml"), entityProperties)

        // 从块到处理函数的链接点击信号
        var entity = entityManager.getEntityById(id)
        entity.clicked.connect(handleClick)

        return entity
    }

    // handle when clicks-----------------------------
    function handleClick(row, column, type) {
        //避免在前面的更改尚未完成时尝试更改字段时可能发生的不必要行为
        if(!isFieldReadyForNewBlockRemoval())
            return

        //复制当前字段，允许我们在不修改真实游戏字段的情况下更改数组
        // 这简化了搜索连接块及其移除的算法
        var fieldCopy = field.slice()

        var blockCount = getNumberOfConnectedBlocks(fieldCopy, row, column, type)
        if(blockCount >= 3) {
            for(var i = 0; i < fieldCopy.length; i++) {
                if(fieldCopy[i] === null) {
                    var block = gameArea.field[i]
                    if(block !== null)
                        block.clickAnimation()
                }
            }
            var clickBlock = gameArea.field[index(row, column)]
            clickBlock.matchSoundPlay()

            removeConnectedBlocks(fieldCopy)
            moveBlocksToBottom()

            // calculate and increase score
            // this will increase the added score for each block, e.g. four blocks will be 1+2+3+4 = 10 points
            var score = (1 + blockCount) * blockCount / 2
            scene.score += score

            // 每10次点击增加难度直到maxTypes==6
            gameArea.clicks++
            if((gameArea.maxTypes < 6) && (gameArea.clicks % 10 == 0))
                gameArea.maxTypes++

            //s游戏结束时发出信号
            if(scene.score >= goal)
                gameClearance()

            // emit signal if game is over
            if(isGameOver())
                gameOver()
        }
    }

    // 递归检查块及其邻居
    // 返回连接块的数目---------------------------------------
    function getNumberOfConnectedBlocks(fieldCopy, row, column, type) {
        // stop recursion if out of bounds
        if(row >= rows || column >= columns || row < 0 || column < 0)
            return 0

        // get block
        var block = fieldCopy[index(row, column)]

        // stop if block was already checked
        if(block === null)
            return 0

        // stop if block has different type
        if(block.type !== type)
            return 0

        // 块具有所需类型，以前未检查过
        var count = 1

        // 从字段副本中删除块，以便我们无法再次检查它
        //同样，在我们完成搜索之后，我们找到的每个正确的块都会在其位置上留下一个空值
        //在字段副本中的位置，然后用它来删除实际字段数组中的块
        fieldCopy[index(row, column)] = null

        // 检查当前块的所有邻居并累积连接块的数量

        //此时，函数使用不同的参数调用自身

        //每次调用都会导致函数再次调用自身，直到上面的检查立即返回0（例如越界、不同的块类型…）
        count += getNumberOfConnectedBlocks(fieldCopy, row + 1, column, type) // add number of blocks to the right
        count += getNumberOfConnectedBlocks(fieldCopy, row, column + 1, type) // add number of blocks below
        count += getNumberOfConnectedBlocks(fieldCopy, row - 1, column, type) // add number of blocks to the left
        count += getNumberOfConnectedBlocks(fieldCopy, row, column - 1, type) // add number of bocks above

        // return number of connected blocks
        return count
    }

    // 删除以前标记的块 --------------------------------
    function removeConnectedBlocks(fieldCopy) {
        // search for blocks to remove
        for(var i = 0; i < fieldCopy.length; i++) {
            if(fieldCopy[i] === null) {
                // remove block from field
                var block = gameArea.field[i]
                if(block !== null) {
                    gameArea.field[i] = null
                    block.remove()
                }
            }
        }
    }

    // 将剩余的块移到底部，并用新块填充列----------------------------
    function moveBlocksToBottom() {
        // check all columns for empty fields
        for(var col = 0; col < columns; col++) {

            // start at the bottom of the field
            for(var row = rows - 1; row >= 0; row--) {

                // find empty spot in grid
                if(gameArea.field[index(row, col)] === null) {

                    // find block to move down
                    var moveBlock = null
                    for(var moveRow = row - 1; moveRow >= 0; moveRow--) {
                        moveBlock = gameArea.field[index(moveRow,col)]

                        if(moveBlock !== null) {
                            gameArea.field[index(moveRow,col)] = null
                            gameArea.field[index(row, col)] = moveBlock
                            moveBlock.row = row
                            moveBlock.fallDown(row - moveRow)
                            break
                        }
                    }

                    // if no block found, fill whole column up with new blocks
                    if(moveBlock === null) {
                        var distance = row + 1
                        for(var newRow = row; newRow >= 0; newRow--) {
                            //place them outside of the game area by setting newRow-distance as the initial grid position at the createBlock-call
                            var newBlock = createBlock(newRow - distance, col)
                            gameArea.field[index(newRow, col)] = newBlock
                            newBlock.row = newRow
                            newBlock.fallDown(distance)
                        }

                        // column already filled up, no need to check higher rows again
                        break
                    }
                }

            } // end check rows starting from the bottom
        } // end check columns for empty fields
    }

    // check if game is over--------------------------------
    function isGameOver() {
        var gameOver = true

        // 复制字段以搜索连接的块，而不修改实际字段
        var fieldCopy = field.slice()

        // 在字段中搜索连接的块
        for(var row = 0; row < rows; row++) {
            for(var col = 0; col < columns; col++) {

                // test all blocks
                //我们还可能会找到没有块的空白点，因为我们在检查它们时会将它们从字段副本中删除，在这种情况下，我们只会继续执行字段中的下一个块。
                var block = fieldCopy[index(row, col)]
                if(block !== null) {
                    var blockCount = getNumberOfConnectedBlocks(fieldCopy, row, col, block.type)

                    if(blockCount >= 3) {
                        gameOver = false
                        break
                    }
                }

            }
        }

        return gameOver
    }

    //如果所有动画都已完成并且新块可能已删除，则返回true--------------------------
    function isFieldReadyForNewBlockRemoval() {
        // check if top row has empty spots or blocks not fully within game area
        for(var col = 0; col < columns; col++) {
            var block = field[index(0, col)]
            if(block === null || block.y < 0)
                return false
        }

        // field is ready
        return true
    }
}
