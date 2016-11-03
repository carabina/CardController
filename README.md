# CardController
### XCode 8 - Swift 3.0 - IOS 10+




[CardController](https://github.com/manuelCarlos/CardController) is a simple container view controller that manages a list of child view controllers and allows them to be presented full screen, and dismissed into a custom menu configuration. All the view animations are customizable and interruptible.



### Requirements
- Xcode 8
- IOS 10+


## Instalation

### Manually
Please add the CardControllerSource folder to your project.

(CocoaPods support coming soon)




## Usage

 Create the custom view controllers that you'll want to add.
 Initialize a CardController object with a base view controller and the array of view controllers that you'll want to manage.

```swift
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

#### Customize the Menu button
Your can change this properties :
- Background color
- tint color
- show / hide

For example, in one of your view controllers:
```swift
override func didMove(toParentViewController parent: UIViewController?) {

    cardController?.menuButton.tintColor = .black
    cardController?.menuButton.backgroundColor = .white
    cardController?.isMenuButtonHidden = false
}
```

#### Customize the System Status Bar

**Important:** Always and only use your **base view controller** to modify the status bar appearance.


## API

#### Public Properties

```swift

public var viewControllers: [UIViewController] {get}
public var baseViewController: UIViewController {get}
public var activeViewController: UIViewController? {get}
public var delegate: CardControllerDelegate? {get set}
public var isMenuButtonHidden: Bool = false {get set}

```




#### CardControllerDelegate

```swift
optional func cardController(_ cardController: CardController, willShow viewController: UIViewController)

optional func cardController(_ cardController: CardController, didShow  viewController: UIViewController)

optional func cardController(_ cardController: CardController, positionForDismissed viewController: UIViewController) -> CGPoint

optional func cardController(_ cardController: CardController, animatorFor viewController: UIViewController) -> UIViewPropertyAnimator?
```
Conforming to CardControllerDelegate lets you fine tune the position the animations for each view controller's view.

----
Try out the demo app. ( screenshot bellow )




<p align="center">
   <img src="http://manuelcarlos.github.io/images/cards.gif" >
</p>



#### License
 - This project is licensed under the terms of the MIT license.
