
//  Created by Dark on 2018/07/22.

import SpriteKit
import GameplayKit

class BattleFieldScene: SKScene {
    
    
    var touchedNodeName: String!
    var touchedNode: SKSpriteNode!
    var previousColumn: Int!
    var previousRow: Int!
    var distinationColumn: Int!
    var distinationRow: Int!
    
    //タイルを配置する場所
    let tilePos = [(0,0),(0,1),(0,2),(0,3),(0,4),(0,5),(0,6),(0,7),(0,8),(0,9),(0,10),
                   (1,0),(1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),
                   (2,0),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,9),(2,10),
                   (3,0),(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),
                   (4,0),(4,1),(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(4,9),(4,10),
                   (5,0),(5,1),(5,2),(5,3),(5,4),(5,5),(5,6),(5,7),(5,8),(5,9),
                   (6,0),(6,1),(6,2),(6,3),(6,4),(6,5),(6,6),(6,7),(6,8),(6,9),(6,10),
                   (7,0),(7,1),(7,2),(7,3),(7,4),(7,5),(7,6),(7,7),(7,8),(7,9),
                   (8,0),(8,1),(8,2),(8,3),(8,4),(8,5),(8,6),(8,7),(8,8),(8,9),(8,10),
                   (9,0),(9,1),(9,2),(9,3),(9,4),(9,5),(9,6),(9,7),(9,8),(9,9),
                   (10,0),(10,1),(10,2),(10,3),(10,4),(10,5),(10,6),(10,7),(10,8),(10,9),(10,10)]
    
    //タイルセット
    let tileSet = SKTileSet(named: "Dark Hexagonal Flat Tile Set")

    //タイルマップノード
    var tileMapNode: SKTileMapNode!
//    var hogeNodes: [SKSpriteNode!] = [SKSpriteNode(imageNamed: "testuniticon.png"), SKSpriteNode(imageNamed: "testuniticon2.png")]

    
    
    // 遷移時に実行される処理
    override func didMove(to view: SKView) {
        
        GlobalVariableManager.shared.unitNodes.append(SKSpriteNode(imageNamed: "testuniticon.png"))
        GlobalVariableManager.shared.unitNodes.append(SKSpriteNode(imageNamed: "testuniticon2.png"))
        
        
        // タイルマップノードを作成
        // タイルのcolumn:rowに合わせてSceneとScrollView内のView(ContentView)のリサイズが必要
        // Sceneは生成されるタイルマップ全体が収まるサイズ(1040:1238)で指定
        tileMapNode = SKTileMapNode(tileSet:tileSet!, columns:11, rows:11, tileSize:CGSize(width:135, height:135))
        print(tileMapNode)
        
        //8方向隣接ノードのオートマッピング機能を無効にする。
        //        tileMapNode.enableAutomapping = false
        
        //タイルセットからタイルグループを取得する。
        //        let tileGroup = tileSet?.tileGroups.first
        let tileGroup = tileSet?.tileGroups[0] // 砂漠
        
        //マスにタイルを配置する。
        for pos in tilePos {
            tileMapNode.setTileGroup(tileGroup, forColumn:pos.0, row:pos.1)
        }
        
        //タイルマップノードの座標を画面中央にする。
        tileMapNode.anchorPoint = CGPoint.zero
//        tileMapNode.position = CGPoint(x:self.frame.minX, y:self.frame.minY)
        //        tileMapNode.position = (self.view?.center)
        //シーンの子ノードにタイルマップノードを追加する。
        self.addChild(tileMapNode)
        
        GlobalVariableManager.shared.unitNodes[0].size = CGSize.init(width: 100, height: 100)
        GlobalVariableManager.shared.unitNodes[0].name = "hoge1"
        GlobalVariableManager.shared.unitNodes[0].zPosition = 1
        GlobalVariableManager.shared.unitNodes[0].position = CGPoint(x:tileMapNode!.centerOfTile(atColumn: 2, row: 3).x, y:tileMapNode!.centerOfTile(atColumn: 0, row: 7).y)
        self.addChild(GlobalVariableManager.shared.unitNodes[0])

        GlobalVariableManager.shared.unitNodes[1].size = CGSize.init(width: 100, height: 100)
        GlobalVariableManager.shared.unitNodes[1].zPosition = 1
        GlobalVariableManager.shared.unitNodes[1].name = "hoge2"
        GlobalVariableManager.shared.unitNodes[1].position = CGPoint(x:tileMapNode!.centerOfTile(atColumn: 4, row: 3).x, y:tileMapNode!.centerOfTile(atColumn: 4, row: 3).y)
        self.addChild(GlobalVariableManager.shared.unitNodes[1])

    }
    
    //画面タッチ開始時の呼び出しメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 触ったNode名を取得
        if self.atPoint(touches.first!.location(in: self)).name != "Default Tile Map" {
            touchedNodeName = self.atPoint(touches.first!.location(in: self)).name
            print("touchedNodeName: \(touchedNodeName)")
            for buffer in GlobalVariableManager.shared.unitNodes {
                if buffer.name == touchedNodeName {
                    self.touchedNode = buffer
                }
        }

        }
        
        // Nodeの現在Tile座標取得
//        let previousLocation = touches.first!.previousLocation(in: self)
        let previousLocation = self.touchedNode.position
        // Tile座標をタイルマップノードを基準にした座標に変換
        let previousPosition = convert(previousLocation, to: scene!)
        // TileのColumnとRowに変換
        self.previousColumn = tileMapNode!.tileColumnIndex(fromPosition: previousPosition)
        self.previousRow = tileMapNode!.tileRowIndex(fromPosition: previousPosition)
    }
    
    // ドラッグ時の呼び出しメソッド
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 選択しているNode名を取得
        let selectedNodeName = self.atPoint(touches.first!.location(in: self)).name
        print("selectedNodeName: \(selectedNodeName!)")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // 指定したTile座標取得
        let distinationLocation = touches.first!.location(in: self)
        // Tile座標をタイルマップノードを基準にした座標に変換
        let distinationPosition = convert(distinationLocation, to: scene!)
        // TileのColumnとRowに変換
        self.distinationColumn = tileMapNode!.tileColumnIndex(fromPosition: distinationPosition)
        self.distinationRow = tileMapNode!.tileRowIndex(fromPosition: distinationPosition)
        
        print("previousColumn: \(self.previousColumn!)")
        print("previousRow: \(self.previousRow!)")
        print("distinationColumn: \(self.distinationColumn!)")
        print("distinationRow: \(self.distinationRow!)")
        

        // 現在Tileのx座標が偶数の場合
        if self.previousColumn % 2 == 0 {
            // 前
            if (distinationColumn - previousColumn) == 0 && (distinationRow - previousRow) == 1 {
                self.moveNode()
                print("Forward")
                // 右斜め前
            } else if (distinationColumn - previousColumn) == 1 && (distinationRow - previousRow) == 0 {
                self.moveNode()
                print("DiagonallyForwardRight")
                // 右斜め後
            } else if (distinationColumn - previousColumn) == 1 && (distinationRow - previousRow) == -1 {
                self.moveNode()
                print("RightRear")
                // 後
            } else if (distinationColumn - previousColumn) == 0 && (distinationRow - previousRow) == -1 {
                self.moveNode()
                print("Backward")
                // 左斜め後
            } else if (distinationColumn - previousColumn) == -1 && (distinationRow - previousRow) == -1 {
                self.moveNode()
                print("LeftRear")
                // 左斜め前
            } else if (distinationColumn - previousColumn) == -1 && (distinationRow - previousRow) == 0 {
                self.moveNode()
                print("DiagonallyForwardLeft")
                // 同位置
            } else if (distinationColumn - previousColumn) == 0 && (distinationRow - previousRow) == 0 {
                print("The same location")
                // 範囲外
            } else {
                print("Out of range")
            }

        // 現在Tileのx座標が奇数の場合
        } else {
            // 前
            if (distinationColumn - previousColumn) == 0 && (distinationRow - previousRow) == 1 {
                self.moveNode()
                print("Forward")
            // 右斜め前
            } else if (distinationColumn - previousColumn) == 1 && (distinationRow - previousRow) == 1 {
                self.moveNode()
                print("DiagonallyForwardRight")
            // 右斜め後
            } else if (distinationColumn - previousColumn) == 1 && (distinationRow - previousRow) == 0 {
                self.moveNode()
                print("RightRear")
            // 後
            } else if (distinationColumn - previousColumn) == 0 && (distinationRow - previousRow) == -1 {
                self.moveNode()
                print("Backward")
            // 左斜め後
            } else if (distinationColumn - previousColumn) == -1 && (distinationRow - previousRow) == 0 {
                self.moveNode()
                print("LeftRear")
            // 左斜め前
            } else if (distinationColumn - previousColumn) == -1 && (distinationRow - previousRow) == 1 {
                self.moveNode()
                print("DiagonallyForwardLeft")
            // 同位置
            } else if (distinationColumn - previousColumn) == 0 && (distinationRow - previousRow) == 0 {
                print("The same location")
            // 範囲外
            } else {
                print("Out of range")
            }
        }
    }
    
    // 指定したTileのcolumnとrowから座標を取得して、Tileの中心に移動
    func moveNode() {
        
        print("\(self.touchedNodeName):\(GlobalVariableManager.shared.unitNodes[0].name)")
        print("\(self.touchedNodeName):\(GlobalVariableManager.shared.unitNodes[1].name)")
        if self.touchedNodeName == GlobalVariableManager.shared.unitNodes[0].name {
            GlobalVariableManager.shared.unit1Actions.removeAll()
            GlobalVariableManager.shared.unit1Actions.append(SKAction.move(to: CGPoint(x:tileMapNode!.centerOfTile(atColumn: distinationColumn, row: distinationRow).x, y:tileMapNode!.centerOfTile(atColumn: distinationColumn, row: distinationRow).y), duration:1.0))
            print(GlobalVariableManager.shared.unit1Actions)
        } else if self.touchedNodeName == GlobalVariableManager.shared.unitNodes[1].name {
            GlobalVariableManager.shared.unit2Actions.removeAll()
            GlobalVariableManager.shared.unit2Actions.append(SKAction.move(to: CGPoint(x:tileMapNode!.centerOfTile(atColumn: distinationColumn, row: distinationRow).x, y:tileMapNode!.centerOfTile(atColumn: distinationColumn, row: distinationRow).y), duration:1.0))
            print(GlobalVariableManager.shared.unit2Actions)
        }
        
        
        print(distinationColumn - previousColumn)
        print(distinationRow - previousRow)
        
        //アクションを実行
//        self.touchedNode.run(action)
        
    }
}
