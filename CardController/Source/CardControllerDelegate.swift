//
//  CardControllerDelegate.swift
//  ContainerControllerCustomTransition
//
//  Created by Manuel Lopes on 02/11/2016.
//  Copyright © 2016 Manuel Carlos. All rights reserved.
//

import UIKit




@objc public protocol CardControllerDelegate: class {
    
    @objc optional func cardController(_ cardController: CardController, willShow viewController: UIViewController)
    @objc optional func cardController(_ cardController: CardController, didShow  viewController: UIViewController)
    @objc optional func cardController(_ cardController: CardController, positionForDismissed viewController: UIViewController) -> CGPoint
    
}
