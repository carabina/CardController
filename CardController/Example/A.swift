//
//  A.swift
//  ContainerControllerCustomTransition
//
//  Created by Manuel Lopes on 31/10/2016.
//  Copyright © 2016 Manuel Carlos. All rights reserved.
//

import UIKit

class A: Card, CardControllerDelegate{


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame.origin = CGPoint(x: 30, y: 75)
        view.backgroundColor = #colorLiteral(red: 0.3882352941, green: 0.2588235294, blue: 0.4196078431, alpha: 1)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(A.tap(_:)))
        view.addGestureRecognizer(tapRecognizer)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         cardController?.delegate = self
        
    }
    

    
    func tap(_ gesture: UIGestureRecognizer){
        
        cardController?.present(self)
    }
    
    
    func cardController(_ cardController: CardController, didShow viewController: UIViewController) {
        print("didShow!!", viewController)
    }
    
    func cardController(_ cardController: CardController, willShow viewController: UIViewController) {
        print("Will show", viewController)
    }
    
    
    
//    func cardController(_ cardController: CardController, positionForDismissed viewController: UIViewController) -> CGPoint {
//        return CGPoint(x:  -100, y: view.frame.origin.y)
//    }
    


}
