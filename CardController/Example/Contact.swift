//
//  A.swift
//  ContainerControllerCustomTransition
//
//  Created by Manuel Lopes on 31/10/2016.
//  Copyright © 2016 Manuel Carlos. All rights reserved.
//

import UIKit

class Contact: Card, CardControllerDelegate{


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame.origin = CGPoint(x: 30, y: 65)
        view.backgroundColor = #colorLiteral(red: 0.3882352941, green: 0.2588235294, blue: 0.4196078431, alpha: 1)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(Contact.tap(_:)))
        view.addGestureRecognizer(tapRecognizer)
        
        
        cardTitle.text = "Contact"
        cardTitle.textColor = #colorLiteral(red: 1, green: 0.5803921569, blue: 0.4196078431, alpha: 1)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         cardController?.delegate = self
        
    }
    

    
    func tap(_ gesture: UIGestureRecognizer){
        
        cardController?.present(self)
    }
    
    
    // MARK:= CardController Delegate methods
    
    func cardController(_ cardController: CardController, didShow viewController: UIViewController) {
        print("didShow!!", viewController)
    }
    
    
    func cardController(_ cardController: CardController, willShow viewController: UIViewController) {
        print("Will show", viewController)
    }
    
    
    // delegate method lets us specify a diferent position where the view controller should be dismissed
    func cardController(_ cardController: CardController, positionForDismissed viewController: UIViewController) -> CGPoint {
        if viewController is Home{
            return CGPoint(x:  -500, y: 210)
        }else{
            return CGPoint(x: 400, y: viewController.view.frame.origin.y)
        }
    }
    


}
