//
//  PopUpHelper.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 11/3/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import UIKit

class PopUpHelper {
    static let shared = PopUpHelper()
    
    func showMessage(message: String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        
        let btnOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(btnOk)
        
        guard let controller =  UIApplication.topViewController() else {
            return
        }
    
        DispatchQueue.main.async {
            controller.present(alert, animated: true, completion: nil)
        }
    }
    
    func showMessageOKCancel(message: String, completionOk: @escaping CompletionClosure) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        
        let btnOk = UIAlertAction(title: "OK", style: .default) { _ in
            completionOk()
        }
        
        let btnCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(btnCancel)
        alert.addAction(btnOk)
        
        guard let controller =  UIApplication.topViewController() else {
            return
        }
        
        DispatchQueue.main.async {
            controller.present(alert, animated: true, completion: nil)
        }
    }
}
