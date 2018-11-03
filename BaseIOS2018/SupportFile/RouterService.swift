//
//  RouterService.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 11/3/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import Foundation


import UIKit

class RouterService {
    static let shared = RouterService()
    
    func goToSignIn() {
        let nc = UINavigationController(rootViewController: SignInRouter.createModule())
        self.getWindow().showFromTop(rootViewController: nc)
    }
    
    func goToMain() {
        DispatchQueue.main.async {
            self.getWindow().showFromBottom(rootViewController: TabbarMainViewController())
        }
    }
}

extension RouterService {
    private func getWindow() -> UIWindow {
        guard let window = UIApplication.shared.keyWindow else {
            print("window cannot shared")
            return UIWindow(frame: UIScreen.main.bounds)
        }
        
        return window
    }
}
