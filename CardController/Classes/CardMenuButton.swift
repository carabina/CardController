
import UIKit



fileprivate extension CALayer {
    
    func applyAnimationTo(_ animation: CABasicAnimation) {
        let copy: CABasicAnimation = animation.copy() as! CABasicAnimation
        
        if copy.fromValue == nil {
            copy.fromValue = presentation()?.value(forKeyPath: copy.keyPath!)
        }
        
        add(copy, forKey: copy.keyPath)
        setValue(copy.toValue, forKeyPath:copy.keyPath!)
    }
    
}//endExt



open class CardMenuButton : UIButton {
    
   private let shortLines: CGPath = {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 30, y:0))

        return path
    }()


    private let top: CAShapeLayer = CAShapeLayer()
    private let bottom: CAShapeLayer = CAShapeLayer()
    private let middle: CAShapeLayer = CAShapeLayer()


    
    
    /// Set the tint color for the button.
    open override  var tintColor: UIColor! {
        get{ return UIColor(cgColor: top.strokeColor!) }
        set{
            top.strokeColor = newValue.cgColor
            middle.strokeColor = newValue.cgColor
            bottom.strokeColor = newValue.cgColor
        }
    }
    
    
    
    /// The line width of the strokes
    public var lineWidth: CGFloat = 3{
        willSet{
            top.lineWidth = newValue
            middle.lineWidth = newValue
            bottom.lineWidth = newValue
        }
    }
    
    
    /// The kind of line cap
    public var lineCap: String = kCALineCapSquare{
        willSet{
            top.lineCap = newValue
            middle.lineCap = newValue
            bottom.lineCap = newValue
        }
    }
    
    
    
    
    /// Toggle the button animation.
    public var showsMenu: Bool = false {
        didSet {
            let strokeStart = CABasicAnimation(keyPath: "strokeStart")
            
            if self.showsMenu {
                strokeStart.toValue = 1
                strokeStart.duration = 0.3
                strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.25, -0.4, 0.5, 1)
                
            } else {
                strokeStart.toValue = 0
                strokeStart.duration = 0.3
                strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.25, 0, 0.5, 1.2)
                strokeStart.beginTime = CACurrentMediaTime() + 0.1
                strokeStart.fillMode = kCAFillModeBackwards
                
            }
            
            
            
            let topTransform = CABasicAnimation(keyPath: "transform")
            topTransform.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, -0.8, 0.5, 1.85)
            topTransform.duration = 0.3
            topTransform.fillMode = kCAFillModeBackwards
            
            let bottomTransform = topTransform.copy() as! CABasicAnimation
            
            if self.showsMenu {
                let translation = CATransform3DMakeTranslation(-4, 0, 0)
                
                topTransform.toValue = NSValue(caTransform3D: CATransform3DRotate(translation, -0.7853975, 0, 0, 1))
                topTransform.beginTime = CACurrentMediaTime() + 0.25
                
                bottomTransform.toValue = NSValue(caTransform3D: CATransform3DRotate(translation, 0.7853975, 0, 0, 1))
                bottomTransform.beginTime = CACurrentMediaTime() + 0.25
            } else {
                topTransform.toValue = NSValue(caTransform3D: CATransform3DIdentity)
                topTransform.beginTime = CACurrentMediaTime() + 0.05
                
                bottomTransform.toValue = NSValue(caTransform3D: CATransform3DIdentity)
                bottomTransform.beginTime = CACurrentMediaTime() + 0.05
            }
            
            top.applyAnimationTo(topTransform)
            middle.applyAnimationTo(strokeStart)
            bottom.applyAnimationTo(bottomTransform)
        }
    }
    

    //MARK:- Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        top.path = shortLines
        middle.path = shortLines
        bottom.path = shortLines

        
        for stroke in [ top, middle, bottom ] {
            stroke.strokeColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1).cgColor
            stroke.lineWidth = lineWidth
            stroke.lineCap = lineCap
            stroke.bounds = (stroke.path?.boundingBoxOfPath)!
            
            layer.addSublayer(stroke)
        }

        top.anchorPoint = CGPoint(x: 28.0 / 30.0, y: 0.5)
        top.position = CGPoint(x: 33, y: 8)

        middle.position = CGPoint(x: 20, y: 17)

        bottom.anchorPoint = CGPoint(x: 28.0 / 30.0, y: 0.5)
        bottom.position = CGPoint(x: 33, y: 26)
    }

   
}// end







