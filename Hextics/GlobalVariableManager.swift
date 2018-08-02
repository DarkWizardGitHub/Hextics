import SpriteKit

// プロジェクト内のグローバル変数管理用シングルトン
class GlobalVariableManager: NSObject {
    
    // シングルトン
    // シングルトンパターンはインスタンスが1個しか生成されないことを保証したい時に使用
    static let shared = GlobalVariableManager()
    
    var allyUnitNodes: [String:SKSpriteNode] = [:]
    var allyUnitActions: [String:[String:SKAction]] = ["AllyUnit1": [:], "AllyUnit2": [:]]
    var enemyUnitNodes: [String:SKSpriteNode] = [:]
    var enemyUnitActions: [String:[String:SKAction]] = [:]
    
    // 動作確認用簡易
    var unit1Actions: [SKAction] = []
    var unit2Actions: [SKAction] = []
    
    // シングルトンの唯一性を保証するためprivateにする
    private override init() {
    }
}
