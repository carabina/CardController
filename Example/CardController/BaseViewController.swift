

import UIKit

class BaseViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
     
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    

    
    // configured  the cardController only once the viewControllers have been added to the parent view controller.
    override func didMove(toParentViewController parent: UIViewController?) {
        
        cardController?.menuButton.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//      cardController?.menuButton.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
//      cardController?.isMenuButtonHidden = false
//      cardController?.menuButton.lineWidth = 6 
        cardController?.menuButton.lineCap = kCALineCapRound
    }
   
    
    // Only the base view controller is responsible for the status bar appearance.
    override var prefersStatusBarHidden: Bool { return true }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{ return .lightContent }


}// end


