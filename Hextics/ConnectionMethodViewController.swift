import UIKit

class ConnectionMethodViewController: UIViewController {
    
    @IBAction func pushInternetBattleButton(_ sender: UIButton) {
        performSegue(withIdentifier: "segue2", sender: nil)
    }
}
