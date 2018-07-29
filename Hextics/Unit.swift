
import Foundation

class Unit: NSObject {
    
    internal var id: String
    internal var typeId: String
    internal var heroId: String
    internal var abilitiesId: Array<String>
    internal var itemsId: Array<String>
    internal var numberOfArmy: Int
    
//    internal var name: String
//    internal var cost: Double
//    internal var toughness: Double
//    internal var meleeAttack: Double
//    internal var meleeDefense: Double
//    internal var rangedAttack: Double
//    internal var rangedDefense: Double
//    internal var magicalAttack: Double
//    internal var magicalDefense: Double
//    internal var moveingRange: Dictionary<String, Int>
//
//    internal var actionStacks: Array<Array<Any>>
    
    
    // Unit Type ID Listファイルパス
    internal let unitTypeIdPlistFilePath = Bundle.main.path(forResource: "Unit Type ID List", ofType:"plist")
    internal let unitTypeIdList: Dictionary<String, Dictionary<String, Any>>
    
    // Hero ID Listファイルパス
    internal let heroIdPlistFilePath = Bundle.main.path(forResource: "Hero ID List", ofType:"plist")
    internal let heroIdList: Dictionary<String, Dictionary<String, Any>>
    
    // Ability ID Listファイルパス
    internal let abilityIdPlistFilePath = Bundle.main.path(forResource: "Ability ID List", ofType:"plist")
    internal let abilityIdList: Dictionary<String, Dictionary<String, Any>>
    
    // Item ID Listファイルパス
    internal let itemIdPlistFilePath = Bundle.main.path(forResource: "Item ID List", ofType:"plist")
    internal let itemIdList: Dictionary<String, Dictionary<String, Any>>
    
    init(id: String, typeId: String, heroId: String, abilitiesId: Array<String>, itemsId: Array<String>, numberOfArmy: Int) {
        
        // plistからデータファイル読み込み
        self.unitTypeIdList = (NSDictionary(contentsOfFile: unitTypeIdPlistFilePath!) as! Dictionary<String, Dictionary<String, Any>>)
        self.heroIdList = (NSDictionary(contentsOfFile: heroIdPlistFilePath!) as! Dictionary<String, Dictionary<String, Any>>)
        self.abilityIdList = (NSDictionary(contentsOfFile: abilityIdPlistFilePath!) as! Dictionary<String, Dictionary<String, Any>>)
        self.itemIdList = (NSDictionary(contentsOfFile: itemIdPlistFilePath!) as! Dictionary<String, Dictionary<String, Any>>)
        
        self.id = id
        self.typeId = typeId
        self.heroId = heroId
        self.abilitiesId = abilitiesId
        self.itemsId = itemsId
        self.numberOfArmy = numberOfArmy
        
//        self.name = (self.unitTypeIdList.filter{ $0.key == typeId })["name"] as! String
//        print(self.name)
    }
    
}
