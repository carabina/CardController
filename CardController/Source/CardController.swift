
//
//  AA.swift
//  Containers
//
//  Created by Manuel Lopes on 29/07/2016.
//  Copyright © 2016 Manuel Carlos. All rights reserved.
//





import UIKit




public extension UIViewController{
    
    private struct AssociatedKeys {
        static var key: UInt8 = 0
    }
    
    public fileprivate (set) var cardController : CardController? {
        get {
            guard let cardVc = objc_getAssociatedObject(self, &AssociatedKeys.key) as? CardController else { return nil } // inital value
            return cardVc
        }
        
        set {
            if let newCardVc = newValue {
                objc_setAssociatedObject(self,&AssociatedKeys.key, newCardVc as CardController , objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
}//EndExt




open class CardController: UIViewController {
    
    
    //MARK:- Public Properties
    public private (set) var viewControllers: [UIViewController]
    public private (set) var baseViewController: UIViewController
    
    public var activeViewController: UIViewController? {return _activeViewController?.controller}
    
    
    public weak var delegate: CardControllerDelegate?
    
    
    //MARK:- Private Properties
    private enum Where{
        case toMenu, out
    }
    
    
    private typealias ControllerInfo = (controller: UIViewController, index: Int, area: CGRect)
    private var _activeViewController: ControllerInfo?
    
  
    
    
    private lazy var controllersInfo: [ ControllerInfo ] = {
        var controllers: [ ControllerInfo ] = []
        self.viewControllers.forEach({ controllers.append( ($0, 0, $0.view.frame) ) })
        return controllers
    }()
    


    
    private var mainAnimator : UIViewPropertyAnimator?


    
    
 
    
    public lazy private (set) var menuButton: MenuButton = {
        let button =  MenuButton(frame: CGRect(origin: .zero, size: CGSize(width: 44, height: 44)  ))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(CardController.menuButtonTapped(_:)), for: .touchUpInside)

        return button
    }()

    
    
    
    convenience init(base: UIViewController, viewControllers: [UIViewController] ){
        self.init(nibName: nil, bundle: nil, base: base, viewControllers: viewControllers)
    }
    
    //MARK:- Init
    convenience init(viewControllers: [UIViewController] = [] ){
        let whitevc = UIViewController()
        whitevc.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let new = Array( viewControllers.dropFirst() )
        self.init(nibName: nil, bundle: nil, base: viewControllers.first ?? whitevc , viewControllers: new )
    }
    
    
    private init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, base: UIViewController, viewControllers: [UIViewController] ) {
        self.baseViewController = base
        self.viewControllers  = viewControllers
      
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

  
   
    
    

    //MARK:- View life cycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    
        addViewControllers()
        view.addSubview(menuButton)
        updateViewConstraints()
     
        
    }
    
    
    
    override open func updateViewConstraints() {
        let margins = view.layoutMarginsGuide
        
        menuButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: 40).isActive = true
        menuButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        super.updateViewConstraints()
    }
    
    
 
    // Returning false lets UIKit know that this container view controller notifies its children of changes in its appearance
    override open var shouldAutomaticallyForwardAppearanceMethods: Bool{
        return false
    }
    
    
    

    
    
    
    // Delegate the apperance of the status to the carController baseViewController.
    override open var prefersStatusBarHidden: Bool{ return baseViewController.prefersStatusBarHidden }
    
    
    
    
    
    //MARK:-Public
    

    
    public func present(_ vc:  UIViewController, with frame: CGRect = UIScreen.main.bounds ){
        presentNew(vc, with: frame)
    }
    

    

    
    
   public  func popActiveViewController(){
        animateAllToMenu()
    }
    
    
    
    
    

    
    
    //MARK:- Private Methods
    
    @objc private func menuButtonTapped(_ sender: AnyObject){
        popActiveViewController()
    }
    
    
    
    
    
    private func addViewControllers(){
        ([baseViewController] + viewControllers).forEach({   addActiveViewcontroller( $0 )    })
    }
    
    
    
    
    private func animateAllToMenu(){
        
        menuButton.showsMenu = false
        mainAnimator?.stopAnimation(true)
        moveAllToMenu()
    }
    
    

    
    private func moveAllToMenu(){
        let all = listControllersToAnimateOut()
        all.forEach({ self.animate(viewController: $0, to: $0.area.origin    ) })
    }
    
    
    
    
    
    
    private func presentNew(_ viewController: UIViewController, with frame: CGRect ){
        guard baseViewController !== viewController else { return }
        
        delegate?.cardController?(self, willShow: viewController)
        
        menuButton.showsMenu = true
        
        dismissActive(viewController: _activeViewController )
        
        setActiveViewController(to: viewController)
        
        moveInactiveViewControllers( .out )
        
        animate(viewController: (viewController, 0, frame), to: frame.origin) {
            self.delegate?.cardController?(self, didShow: viewController)
        }
        
        
    }
    
    
    
    
    
    
    
    private func  moveInactiveViewControllers( _ to: Where){
        
        let inactiveVC: [ControllerInfo] = listControllersToAnimateOut(except: (_activeViewController?.controller)!  )
        switch to {
        case .toMenu:
            inactiveVC.forEach({
                
                self.animate(viewController: $0, to: $0.area.origin    )
                
                 })
        case .out:
            inactiveVC.forEach({
                let position = self.delegate?.cardController?(self, positionForDismissed: $0.controller)
                let defaultPoint = CGPoint(x: 400, y: $0.area.origin.y)
                self.animate(viewController: $0, to: position ?? defaultPoint  )
            
            })
        }
    }
    
    
    
    
    
    
    private func setActiveViewController(to vc: UIViewController ){
        _activeViewController = (vc, 0 , vc.view.frame)
    }
    
    
    
    
    private func dismissActive( viewController active: ControllerInfo?){
        
        if  let activeVC = active {
            let toMenu = animator(for: activeVC.controller , to: activeVC.area )
            toMenu.startAnimation()
        }
    }

    
    
    
    
    private func animate(viewController vc: ControllerInfo?, to position: CGPoint, completion: (()->())?  = nil){
    
        if  let activeVC = vc {
            let toMenu = animator(for: activeVC.controller , to: CGRect(origin: position, size: activeVC.area.size) )
            toMenu.addCompletion({_ in  completion?() })
            toMenu.startAnimation()
        }
        
        
    }

    
    
   private func animator(for vc: UIViewController, to position: CGRect) -> UIViewPropertyAnimator{
        
        let animator = createAnimator(for: vc)
        animator.addAnimations {  vc.view.frame = position   }
        animator.addCompletion({_ in  })
        return animator
    }
    
    
    
    
  private  func createAnimator(for vc: UIViewController ) -> UIViewPropertyAnimator{
        
        let mass: CGFloat = 0.19
        let stiffness: CGFloat = 15.5
        let damping =  2.6 * sqrt(mass * stiffness)
        let underDamped = 0.5 * damping
        let springParameters = UISpringTimingParameters(mass: mass, stiffness: stiffness, damping: underDamped, initialVelocity: .zero)
        let animator = UIViewPropertyAnimator(duration: 1, timingParameters: springParameters)
        animator.isUserInteractionEnabled = false
        return animator
    }
    
    
    
    
    
    private func removeInactiveViewController(_ inactiveViewController: UIViewController?){
        
        guard let inActiveVC = inactiveViewController else { return }
        inActiveVC.willMove(toParentViewController: nil)
        inActiveVC.view.removeFromSuperview()
        inActiveVC.removeFromParentViewController()
        
    }
    
    
    
    
    private func addActiveViewcontroller(_ activeViewController: UIViewController? ){
        
        guard let activeVC = activeViewController else { return }
        addChildViewController(activeVC)
        view.insertSubview(activeVC.view, belowSubview: menuButton)
        activeVC.cardController = self
        
        if activeVC is CardControllerDelegate{
            activeVC.cardController?.delegate = activeVC as? CardControllerDelegate
        }
        
        activeVC.didMove(toParentViewController: self)
       print(activeVC is CardControllerDelegate)
        
    }
    
    


    private func listControllersToAnimateOut( except minus: UIViewController? = nil) -> [ControllerInfo]{
    
        var controllers: [ControllerInfo] = []
            for (i, value ) in controllersInfo.enumerated(){
                if value.controller !== minus{
                    controllers.append( (value.controller, i, value.area) )
                }
            }
        
        return controllers
    }
    
    
    
  
    
    
} // end


