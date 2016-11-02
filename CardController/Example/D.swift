//
//  D.swift
//  ContainerControllerCustomTransition
//
//  Created by Manuel Lopes on 02/11/2016.
//  Copyright © 2016 Manuel Carlos. All rights reserved.
//

import UIKit


class D: Card{


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame.origin = CGPoint(x: 145, y: 225)
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9019607843, blue: 0.5176470588, alpha: 1)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(D.tap(_:)))
        view.addGestureRecognizer(tapRecognizer)
        
    }
    
    
    
    
    func tap(_ gesture: UIGestureRecognizer){
        
        cardController?.present(self)
        
    }
    
    
  

}
