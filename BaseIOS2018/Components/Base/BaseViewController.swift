//
//  BaseViewController.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import Foundation
import UIKit

enum StyleNavigation {
    case left
    case right
}

class BaseViewController: UIViewController {
    
    let mainBackgroundColor = UIColor.white
    let mainNavigationBarColor = UIColor.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setUpNavigation()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    func setUpNavigation() {
        //---
        self.navigationController?.navigationBar.barTintColor = mainNavigationBarColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = mainBackgroundColor
    }
}

// MARK: Add button left, right, title
extension BaseViewController {
    func addButtonToNavigation(image: UIImage, style: StyleNavigation, action: Selector?) {
        let btn = UIButton()
        btn.setImage(image, for: .normal)
        if let _action = action {
            btn.addTarget(self, action: _action, for: .touchUpInside)
        }
        
        btn.frame = CGRect(x: 0, y: 0, width: 60, height: 44)
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            btn.contentHorizontalAlignment = .left
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
            btn.contentHorizontalAlignment = .right
        }
    }
    
    func addTwoButtonToNavigation(image1: UIImage, action1: Selector?, image2: UIImage, action2: Selector?) {
        let btn1 = UIButton()
        btn1.setImage(image1, for: .normal)
        if let _action = action1 {
            btn1.addTarget(self, action: _action, for: .touchUpInside)
        }
        
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        btn1.contentHorizontalAlignment = .right
        let button1 = UIBarButtonItem(customView: btn1)
        
        //---
        let btn2 = UIButton()
        btn2.setImage(image2, for: .normal)
        if let _action = action2 {
            btn2.addTarget(self, action: _action, for: .touchUpInside)
        }
        btn2.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn2.contentHorizontalAlignment = .right
        
        let button2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.rightBarButtonItems = [button1, button2]
    }
    
    func addButtonTextToNavigation(title: String, style: StyleNavigation, action: Selector?, textColor: UIColor = UIColor.white) {
        let btn = UIButton()
        
        var _title = title
        if style == .right {
            _title = title.uppercased()
        }
        
        btn.setAttributed(title: _title, color: textColor, font: UIFont.systemFont(ofSize: 17))
        if let _action = action {
            btn.addTarget(self, action: _action, for: .touchUpInside)
        }
        btn.sizeToFit()
        
        let button = UIBarButtonItem(customView: btn)
        if style == .left {
            self.navigationItem.leftBarButtonItem = button
        } else {
            self.navigationItem.rightBarButtonItem = button
        }
    }
    
    func setTitleNavigation(title: String, textColor: UIColor = UIColor.white, action: Selector? = nil ) {
        let lb = UILabel()
        lb.text             = title
        lb.textAlignment    = .center
        lb.numberOfLines    = 2
        lb.textColor        = textColor
        lb.sizeToFit()
        
        let tap = UITapGestureRecognizer(target: self, action: action)
        lb.addGestureRecognizer(tap)
        let vTest = UIView()
        vTest.frame = CGRect(x: 0, y: 0, width: 375, height: 44)
        vTest.addSubview(lb)
        lb.centerSuperview()
        self.navigationItem.titleView = vTest
    }
}

// MARK: handle keyboard
extension BaseViewController {
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: Notification) {
        
    }
    @objc func keyboardWillHide(notification: Notification) {
        
    }
}
