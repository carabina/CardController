//
//  D.swift
//  ContainerControllerCustomTransition
//
//  Created by Manuel Lopes on 02/11/2016.
//  Copyright © 2016 Manuel Carlos. All rights reserved.
//

import UIKit


class Home: Card{


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame.origin = CGPoint(x: 120, y: 210)
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9019607843, blue: 0.5176470588, alpha: 1)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(Home.tap(_:)))
        view.addGestureRecognizer(tapRecognizer)
        
        cardTitle.text = "Home"
        cardTitle.textColor = #colorLiteral(red: 0.7098039216, green: 0.3529411765, blue: 0.4196078431, alpha: 1)
       
    }
    
    
    
    
    
    
    func tap(_ gesture: UIGestureRecognizer){
        
        cardController?.present(self)
        
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        
      
        cardController?.isMenuButtonHidden = false
    }
    
    
  

}
