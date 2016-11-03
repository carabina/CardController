
//  Created by Manuel Lopes on 02/11/2016.
//  Copyright © 2016 Manuel Carlos. All rights reserved.


import UIKit



/**
 Use a card controller delegate (a custom object that implements this protocol)
 to modify behavior when a view controller is presented or dismissed in a cardController object.
 
 */
@objc public protocol CardControllerDelegate: class {
    
    /// Called just before the card controller displays a view controller’s view full screen.
    ///
    /// - Parameters:
    ///   - cardController: The cardController that is showing the view.
    ///   - viewController: The view controller whose view is about to be fully displayed.
    @objc optional func cardController(_ cardController: CardController, willShow viewController: UIViewController)
    
    
    /// Called just after the card controller displays a view controller’s view full screen.
    ///
    /// - Parameters:
    ///   - cardController: The cardController that is showing the view.
    ///   - viewController: The view controller whose view just got fully displayed.
    @objc optional func cardController(_ cardController: CardController, didShow  viewController: UIViewController)
    
    
    
    /// Use this method to return a custom position to use for the view controller when it gets dismissed.
    /// The default 
    ///
    /// - Parameters:
    ///   - cardController: The cardController that is moving the view.
    ///   - viewController: The view controller's view we want to position.
    /// - Returns: The point where the view should animate to when the view controller gets dismissed.
    @objc optional func cardController(_ cardController: CardController, positionForDismissed viewController: UIViewController) -> CGPoint
    
    
    
    /// Use this method to return a custom animator object that will replace the default animation for the view controller.
    ///
    /// - Parameters:
    ///   - cardController: The cardController that is moving the view.
    ///   - viewController: The view controller's view which the animator will act upon.
    /// - Returns: The new animator object that replaces the default animation for this view controller.
    @objc optional func cardController(_ cardController: CardController, animatorFor viewController: UIViewController) -> UIViewPropertyAnimator?

    
    
}//End
