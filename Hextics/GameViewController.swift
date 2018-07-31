
//  Created by Dark on 2018/07/22.

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = contentView as SKView? {
            
            // ContentViewに合わせてSceneがscaleModeに従い拡大縮小されると考えられる為任意の倍率になる様に各デバイス毎にContentViewのサイズを調整
            // iPhoneの機種判定
            switch (UIScreen.main.nativeBounds.height) {
            case 480:
                // iPhone
                // iPhone 3G
                // iPhone 3GS
                break
            case 960:
                // iPhone 4
                // iPhone 4S
                break
            case 1024:
                // iPad Mini
                // iPad
                // iPad 2
                break
            case 1136:
                // iPhone 5
                // iPhone 5s
                // iPhone 5c
                // iPhone SE
                break
            case 1334:
                // iPhone 6
                // iPhone 6s
                // iPhone 7
                // iPhone 8
                print("1334")
                view.frame.size.width = 375
                view.frame.size.height = 497
                break
            case 2048:
                // iPad Mini 2
                // iPad Mini 3
                // iPad Mini 4
                // iPad 3
                // iPad 4
                // iPad Air
                // iPad Air 2
                // iPad Pro 9.7
                break
            case 2208:
                // iPhone 6 Plus
                // iPhone 6s Plus
                // iPhone 7 Plus
                // iPhone 8 Plus
                print(Utilities.shared.getDeviceName())
                view.frame.size.width = 414
                view.frame.size.height = 616
                break
            case 2224:
                // iPad Pro 10.5
                break
            case 2436:
                //iPhone X
                break
            case 2732:
                // iPad Pro 12.9
                break
            default:
                break
            }
            
            // SKScene(BattleFieldScene.sks)を読み込む
            if let scene = SKScene(fileNamed: "BattleFieldScene") {
                // アスペクト比を保持したままサイズをフィット
                // シーンの全体が表示されるが、ビューとの縦横比が違うとビューに余白が生じる
                scene.scaleMode = .aspectFit
                // Present the scene
                view.presentScene(scene)
            }
            
            // Sprite Kit applies additional optimizations to improve rendering performance
            view.ignoresSiblingOrder = true
            
            // sceneのfpsを表示（開発用）
            view.showsFPS = true
            // sceneに表示されているノード数を表示（開発用）
            view.showsNodeCount = true
        }
        // おかゆ様作成のズーム処理関数
        initScroll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    @IBAction func pushCompleteCommand(_ sender: UIButton) {
        
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "queue", attributes: .concurrent)
        
        dispatchGroup.enter()
        dispatchQueue.async(group: dispatchGroup) {
            for buffer in GlobalVariableManager.shared.unit1Actions {
                GlobalVariableManager.shared.unitNodes[0].run(buffer)
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        dispatchQueue.async(group: dispatchGroup) {
            for buffer in GlobalVariableManager.shared.unit2Actions {
                GlobalVariableManager.shared.unitNodes[1].run(buffer)
                dispatchGroup.leave()
            }
        }
        
        // 全ての非同期処理完了後にメインスレッドで処理
        dispatchGroup.notify(queue: .main) {
            print("All Process Done!")
        }
        
        
        ////アクションをまとめる。
        //let actionAll = SKAction.sequence([action1,action2,action3])
        //
        ////アクションを実行する。

    }
}

extension GameViewController:UIScrollViewDelegate {
    func initScroll() {
        scrollView.delegate = self
        scrollView.zoomScale = 1
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 2
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print("zooooooming®")
        return contentView
    }
}
