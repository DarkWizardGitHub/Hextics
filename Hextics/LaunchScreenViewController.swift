import UIKit

class LaunchScreenViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // durationはアニメーション時間
        // delayは開始までの遅延時間
        // optionsではアニメーション中に使用するタイミング曲線の種類やアニメーションの逆再生などを指定
        // animationsクロージャの中でアニメーションしたいUIViewクラスのプロパティの値を変更
        // completionクロージャはアニメーションが完了したタイミングで呼ばれるクロージャ
        
        // 少し縮小するアニメーション
        UIView.animate(withDuration: 0.5,
                       delay: 2.0,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: { () in
                        self.logoImage.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: { (Bool) in
            
        })
        
        // 拡大させて、消えるアニメーション
        UIView.animate(withDuration: 0.5,
                       delay: 2.5,
                       options: UIViewAnimationOptions.curveEaseOut,
                       animations: { () in
                        self.logoImage.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                        self.logoImage.alpha = 0
        }, completion: { (Bool) in
            self.logoImage.removeFromSuperview()
            self.start()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func start() {
        performSegue(withIdentifier: "segue1", sender: nil)
    }
}
