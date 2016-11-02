//
//  C.swift
//  ContainerControllerCustomTransition
//
//  Created by Manuel Lopes on 31/10/2016.
//  Copyright © 2016 Manuel Carlos. All rights reserved.
//

import UIKit

class C: Card{
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame.origin = CGPoint(x: 105, y: 175)
        view.backgroundColor = #colorLiteral(red: 1, green: 0.5803921569, blue: 0.4196078431, alpha: 1)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(C.tap(_:)))
        view.addGestureRecognizer(tapRecognizer)

    }
    
    
    
    
    func tap(_ gesture: UIGestureRecognizer){
        
        cardController?.present(self)

    }

    
//    
//    override func beginAppearanceTransition(_: Bool, animated: Bool){
//        print("beguin appearance", self.description )
//    }
//    
//    override func endAppearanceTransition(){
//        print("end appreacence", self.description)
//    }
    
    
    
    
}

