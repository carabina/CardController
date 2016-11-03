//
//  C.swift
//  ContainerControllerCustomTransition
//
//  Created by Manuel Lopes on 31/10/2016.
//  Copyright © 2016 Manuel Carlos. All rights reserved.
//

import UIKit

class Work: Card{
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame.origin = CGPoint(x: 90, y: 170)
        view.backgroundColor = #colorLiteral(red: 1, green: 0.5803921569, blue: 0.4196078431, alpha: 1)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(Work.tap(_:)))
        view.addGestureRecognizer(tapRecognizer)
        
        cardTitle.text = "Work"
        cardTitle.textColor = #colorLiteral(red: 0.3882352941, green: 0.2588235294, blue: 0.4196078431, alpha: 1)
        
    }
    
    
    
    
    func tap(_ gesture: UIGestureRecognizer){
        
        cardController?.present(self)
    }


    
    
    
    
}//end

