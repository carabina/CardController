# CardController
### XCode 8 - Swift 3.0 - IOS 10+




[CardController](https://github.com/manuelCarlos/CardController) is a simple container view controller that manages a list of child view controllers and allows them to be presented full screen, and dismissed into a custom menu configuration. All the view animations are customizable and interruptible.



### Requirements
- Xcode 8
- IOS 10+


## Instalation

To install with [CocoaPods](http://cocoapods.org), add the following line to your Podfile:

```ruby
pod "CardController"
```


## Usage

 1. Create the custom view controllers that you'll want to add.
 2. Initialize a CardController object with a base view controller and an array of view controllers that you'll want to manage.

```swift
import CardController
//  ...
let base  = BaseViewController()
let about = About()
let work  = Work()
let home  = Home()

let cardC = CardController(base: base, viewControllers: [ about, work, home ])

```

#### Present and Dismiss a view controller
From anywhere inside your view controllers you can:
- animate your controller's view into full screen
```swift
  cardController?.present(self)
```

- move the views back into a menu position.
```swift
cardController?.popActiveViewController()
```

#### Customize the Menu Button’s Appearance

For example, in one of your view controllers:
```swift
override func didMove(toParentViewController parent: UIViewController?) {

    cardController?.menuButton.tintColor = .black
    cardController?.menuButton.backgroundColor = .white
    cardController?.isMenuButtonHidden = false
    cardController?.menuButton.lineWidth = 6
}

```
#### Customize the animation of a specific view controller.
Adopt the ```CardControllerDelegate``` protocol and implement this delegate method, returning your custom animator object.

```swift
func cardController(_ cardController: CardController, animatorFor viewController: UIViewController) -> UIViewPropertyAnimator? {

    if viewController is AboutViewController{
        let timming: UITimingCurveProvider = UICubicTimingParameters(animationCurve: .easeInOut)
        let homeAnimator = UIViewPropertyAnimator(duration: TimeInterval(1), timingParameters: timming)
        return homeAnimator
    }
    return nil
}
```


#### Customize the System Status Bar

**Important:** Always and only use your **base view controller** to modify the status bar appearance.


## API

#### CardController

```swift
init()
init( base: UIViewController, viewControllers: [UIViewController] )
init( viewControllers: [UIViewController] )

var activeViewController: UIViewController? {get}
var baseViewController:   UIViewController {get}
var viewControllers:      [UIViewController] {get}
var delegate: CardControllerDelegate? {get set}
var isMenuButtonHidden: Bool {get set}
var menuButton: CardMenuButton {get}

func present( _ vc:  UIViewController )
func present( _ vc:  UIViewController, with frame: CGRect )
func popActiveViewController()

```

#### CardMenuButtom

```swift
var tintColor: UIColor {get set}
var lineWidth: CGFloat {get set}
var lineCap: String {get set}
var showsMenu: Bool {get set}

```

#### CardControllerDelegate

```swift
optional func cardController(_ cardController: CardController, willShow viewController: UIViewController)
optional func cardController(_ cardController: CardController, didShow  viewController: UIViewController)
optional func cardController(_ cardController: CardController, positionForDismissed viewController: UIViewController) -> CGPoint
optional func cardController(_ cardController: CardController, animatorFor viewController: UIViewController) -> UIViewPropertyAnimator?
```


----
screenshot of the demo app

<p align="center">
   <img src="http://manuelcarlos.github.io/images/cards.gif" >
</p>



#### License
 - This project is licensed under the terms of the MIT license.
