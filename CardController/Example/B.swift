//
//  B.swift
//  ContainerControllerCustomTransition
//
//  Created by Manuel Lopes on 31/10/2016.
//  Copyright © 2016 Manuel Carlos. All rights reserved.
//

import UIKit

class B: Card{
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame.origin = CGPoint(x: 65, y: 125)
        
        view.backgroundColor = #colorLiteral(red: 0.7098039216, green: 0.3529411765, blue: 0.4196078431, alpha: 1)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(B.tap(_:)))
        view.addGestureRecognizer(tapRecognizer)
        
    }
    
    
    
    
    func tap(_ gesture: UIGestureRecognizer){
        
        cardController?.present(self)
 
    }
    
    
    
//    override func beginAppearanceTransition(_: Bool, animated: Bool){
//        print("beguin appearance", self.description )
//    }
//    
//    override func endAppearanceTransition(){
//        print("end appreacence", self.description)
//    }

    
}

