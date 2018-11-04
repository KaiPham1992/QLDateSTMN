//
//  AppDelegate.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        RouterService.shared.goToSignIn()
        IQKeyboardManager.shared.enable = true
        return true
    }
}

