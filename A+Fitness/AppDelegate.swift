//
//  AppDelegate.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-02.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let rootView = MainTabBarController()
        rootView.selectedIndex = 0
        let mainNav = UINavigationController(rootViewController: rootView)
        
        mainNav.navigationBar.tintColor = myColor.textWhite
        mainNav.navigationBar.barTintColor = UIColor(r: 0, g: 0, b: 0, a: 0)
        mainNav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: myColor.textWhite]
        mainNav.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        mainNav.navigationBar.shadowImage = UIImage()
        mainNav.hidesBarsOnSwipe = true
        
        
        window?.rootViewController = mainNav
        UIApplication.shared.statusBarStyle = .lightContent
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        return handled
    }
}
