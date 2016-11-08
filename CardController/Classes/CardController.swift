


import UIKit

@available(iOS 10.0, *)
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



@available(iOS 10.0, *)
open class CardController: UIViewController {
    
    
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


    
    
    //MARK:- Public Properties
    public private (set) var viewControllers: [UIViewController]
    public private (set) var baseViewController: UIViewController
    public var activeViewController: UIViewController? {return _activeViewController?.controller}
    
    
    /// The delegate of the card controller object.
    public weak var delegate: CardControllerDelegate?
    
    
    public var isMenuButtonHidden: Bool = false {
        didSet {
            view.setNeedsLayout()
        }
    }
    
    
    
    public lazy private (set) var menuButton: CardMenuButton = {
        let button =  CardMenuButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(CardController.menuButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()
    
    
    
    //MARK:- Init
   public convenience init(base: UIViewController, viewControllers: [UIViewController] ){
        self.init(nibName: nil, bundle: nil, base: base, viewControllers: viewControllers)
    }
    
  
   public convenience init(viewControllers: [UIViewController] = [] ){
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
    
   open override  func viewDidLoad() {
        super.viewDidLoad()
    
        addViewControllers()
        addMenuButton()
    }
    
    
    
   open override  func updateViewConstraints() {
    
        if !isMenuButtonHidden{
            let margins = view.layoutMarginsGuide
            let statuBarHidden = baseViewController.prefersStatusBarHidden
            let topInset: CGFloat = statuBarHidden ? 15 : 40
            menuButton.topAnchor.constraint(equalTo: margins.topAnchor, constant: topInset ).isActive = true
            menuButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0).isActive = true
            menuButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        }
        super.updateViewConstraints()
    }
    
    
 
    // Returning false lets UIKit know that this container view controller notifies its children of changes in its appearance
    open override  var shouldAutomaticallyForwardAppearanceMethods: Bool{  return false  }
    
    
    // Delegate the apperance of the status to the carController baseViewController.
    open override  var prefersStatusBarHidden: Bool{ return baseViewController.prefersStatusBarHidden }
    
    
    
 
    
    //MARK:- Public Methods
    

    
    open func present(_ vc:  UIViewController, with frame: CGRect = UIScreen.main.bounds ){
        presentNew(vc, with: frame)
    }
    


   open  func popActiveViewController(){
        animateAllToMenu()
    }
    

    
    
    //MARK:- Private Methods
    
    @objc private func menuButtonTapped(_ sender: AnyObject){
        popActiveViewController()
    }
    
    
    private func addMenuButton(){
        
        if !isMenuButtonHidden{
            view.addSubview(menuButton)
            updateViewConstraints()
        }
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
    
    
    private static let defaultTimming: UITimingCurveProvider = {
        
        let mass: CGFloat = 0.003
        let stiffness: CGFloat = 1.00
        let damping: CGFloat =  0.08
        let defaultSpring = UISpringTimingParameters(mass: mass, stiffness: stiffness, damping: damping, initialVelocity: .zero)
       
        return defaultSpring
    }()
    
    
    
    func defaultTimming2() -> UITimingCurveProvider{
        return UISpringTimingParameters(mass: 1.0, stiffness: 1.0, damping: 1.0, initialVelocity: .zero)
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
            inactiveVC.forEach({  self.animate(viewController: $0, to: $0.area.origin)  })
        case .out:
            inactiveVC.forEach({
                let position = self.delegate?.cardController?(self, positionForDismissed: $0.controller)
                let defaultPoint = CGPoint(x: UIScreen.main.bounds.width, y: $0.area.origin.y)
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
    
    if let  customAnimator = delegate?.cardController?(self, animatorFor: vc){
                customAnimator.addAnimations {  vc.view.frame = position   }
            return customAnimator
        }
    
        let animator = createAnimator()
        animator.addAnimations {  vc.view.frame = position   }
        animator.addCompletion({_ in  })
        return animator
    }
    
    
    
    
    
    private  func createAnimator(with duration: TimeInterval = TimeInterval(1),
                                 timingParameters parameters: UITimingCurveProvider = defaultTimming ) -> UIViewPropertyAnimator{
        
        let animator = UIViewPropertyAnimator(duration: duration, timingParameters: parameters)
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
    }
    
    


    private func listControllersToAnimateOut( except minus: UIViewController? = nil) -> [ControllerInfo]{
        return controllersInfo.filter({ ( vc, _, _ ) in vc !== minus  })
    }
    
  
    
    
} // end


