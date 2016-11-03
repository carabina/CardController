//
//  AppDelegate.swift
//  ContainerControllerCustomTransition
//
//  Created by Manuel Lopes on 30/07/2016.


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let base = BaseViewController()
    
        let a = Contact()
        let b = About()
        let c = Work()
        let home = Home()
        
        
        let cardC = CardController(base: base, viewControllers: [ a, b, c, home ])
        cardC.menuButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        cardC.menuButton.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        window?.rootViewController = cardC
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
    
    
}

