//
//  SecondaryViewController.swift
//  ContainerControllerCustomTransition
//
//  Created by Manuel Lopes on 30/07/2016.


import UIKit

class Card: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.layer.cornerRadius = 10
        view.layer.shadowColor =  #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor
        view.layer.shadowRadius = 2.0
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
}// end
