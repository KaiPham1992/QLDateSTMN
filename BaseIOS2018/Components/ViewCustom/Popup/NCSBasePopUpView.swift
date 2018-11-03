//
//  NCSBasePopUpView.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 11/3/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import UIKit

class NCSBasePopUpView: UIView {
    let vBackGround: UIView = {
        let view                = UIView()
        view.backgroundColor    = AppColor.backgroundMenu
        return view
    }()
    
    let vContent: UIView = {
        let view                = UIView()
        view.backgroundColor    = AppColor.main
        
        return view
    }()
    
    lazy var btnOver: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(self.btnOverTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //    var heightVContent: NSLayoutConstraint!
    
    func setupView() {
        addSubview(vBackGround)
        vBackGround.fillSuperview()
        vBackGround.addSubview(btnOver)
        btnOver.fillSuperview()
        vBackGround.addSubview(vContent)
    }
    
    @objc func btnOverTapped() {
        hidePopUp()
    }
    
    func showPopUp(height: CGFloat = 200) {
        if let window = UIApplication.shared.keyWindow {
            vContent.frame = CGRect(x: 0, y: window.frame.height + height, width: window.frame.width, height: height)
            
            window.addSubview(self)
            self.fillSuperview()
            self.vBackGround.alpha = 0
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseOut, animations: { [unowned self] in
                self.vBackGround.alpha = 1
                if #available(iOS 11, *) {
                    self.vContent.frame = CGRect(x: 0, y: window.safeAreaLayoutGuide.layoutFrame.height - height, width: window.safeAreaLayoutGuide.layoutFrame.width, height: height)
                } else {
                    self.vContent.frame = CGRect(x: 0, y: window.frame.height - height, width: window.frame.width, height: height)
                }
                }, completion: nil)
        }
    }
    func hidePopUp(success: ((Bool) -> Void)? = nil) {
        self.vBackGround.alpha = 1
        guard let window = UIApplication.shared.keyWindow else { return }
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.vContent.frame = CGRect(x: 0, y: window.frame.height + 1000, width: self.vContent.frame.width, height: self.vContent.frame.height)
            
            }, completion: { [weak self] _ in
                guard let strongSelf = self else {
                    success?(false)
                    return }
                
                strongSelf.vBackGround.alpha = 0
                strongSelf.removeFromSuperview()
                success?(true)
        })
        
    }
}
