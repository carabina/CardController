//
//  ViewController.swift
//  ContainerControllerCustomTransition
//
//  Created by Manuel Lopes on 30/07/2016.


import UIKit

class BaseViewController: UIViewController {
    
  

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    
//    override func beginAppearanceTransition(_: Bool, animated: Bool){
//        print("beguin appearance", self.description )
//    }
//    
//    override func endAppearanceTransition(){
//        print("end appreacence", self.description)
//    }
//    
//    
//    
//    func tap(_ gesture: UIGestureRecognizer){
//        
//        cardController?.present(self)
//        
//    }
   
    
    // Only the base view controller is responsible for the status bar appearance.
    override var prefersStatusBarHidden: Bool { return false}


}// end


