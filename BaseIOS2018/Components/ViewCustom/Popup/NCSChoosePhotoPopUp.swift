//
//  NCSChoosePhotoPopUp.swift
//  GoFixCustomer
//
//  Created by Kai Pham on 8/20/18.
//  Copyright © 2018 gofix.vinova.sg. All rights reserved.
//

import UIKit

typealias CompletionClosure = (() -> Void)

class NCSChoosePhotoPopUp: UIView {
        lazy var btnOver: UIButton = {
            let button = UIButton()
            button.addTarget(self, action: #selector(self.btnOverTapped), for: .touchUpInside)
            return button
        }()
    
        let vContent: UIView = {
            let view                = UIView()
            view.backgroundColor    = .clear
            
            return view
        }()
    
        let btnPhoto: UIButton = {
            let btn = UIButton()
            btn.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 5)
            btn.setAttributed(title: "Photo Album", color: UIColor.white, font: UIFont.systemFont(ofSize: 15))
            btn.backgroundColor = UIColor(red: 219/255, green: 82/255, blue: 83/255, alpha: 1)
    
            return btn
        }()
    
        let btnCamera: UIButton = {
            let btn = UIButton()
            btn.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 5)
            btn.setAttributed(title: "Camera", color: UIColor.white, font: UIFont.systemFont(ofSize: 15))
            btn.backgroundColor = UIColor(red: 219/255, green: 82/255, blue: 83/255, alpha: 1)
    
            return btn
        }()
    
    var completionChooseAlbum: CompletionClosure?
    var completionChooseCamera: CompletionClosure?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        addSubview(vContent)
        vContent.addSubview(btnOver)
        btnOver.fillSuperview()
        
        vContent.addSubview(btnCamera)
        vContent.addSubview(btnPhoto)
        
        btnCamera.centerYToView(view: vContent, constant: -25)
        btnPhoto.centerYToView(view: vContent, constant: 25)
        btnCamera.centerXToSuperview()
        btnPhoto.centerXToSuperview()
        btnCamera.widthAnchor.constraint(equalTo: vContent.widthAnchor, multiplier: 0.8).isActive = true
        btnPhoto.widthAnchor.constraint(equalTo: vContent.widthAnchor, multiplier: 0.8).isActive = true
        
        btnCamera.anchor(heightConstant: 40)
        btnCamera.setBorder(cornerRadius: 20)
        btnPhoto.anchor(heightConstant: 40)
        btnPhoto.setBorder(cornerRadius: 20)
        
        btnPhoto.addTarget(self, action: #selector(btnPhotoAlbumTapped), for: .touchUpInside)
        btnCamera.addTarget(self, action: #selector(btnCameraTapped), for: .touchUpInside)
    }
    
    @objc func btnOverTapped() {
        hidePopUp()
    }
    
    func showPopUp() {
        if let window = UIApplication.shared.keyWindow {
            if #available(iOS 11.0, *) {
                vContent.frame = CGRect(x: window.safeAreaLayoutGuide.layoutFrame.minX, y: window.safeAreaLayoutGuide.layoutFrame.maxY, width: window.safeAreaLayoutGuide.layoutFrame.width, height: window.safeAreaLayoutGuide.layoutFrame.height)
            } else {
                // Fallback on earlier versions
                vContent.frame = CGRect(x: window.frame.minX, y: window.frame.maxY, width: window.frame.width, height: window.frame.height)
            }
            
            window.addSubview(self)
            self.fillSuperview()
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseOut, animations: { [unowned self] in
                
                if #available(iOS 11, *) {
                    self.vContent.frame = window.safeAreaLayoutGuide.layoutFrame
                } else {
                     self.vContent.frame = window.frame
                }
                }, completion: nil)
        }
    }
    
    func hidePopUp(success: ((Bool) -> Void)? = nil) {
        
        guard let window = UIApplication.shared.keyWindow else { return }
        UIView.animate(withDuration: 0.3, animations: { [unowned self] in
            self.vContent.frame = CGRect(x: 0, y: window.frame.height + 1000, width: self.vContent.frame.width, height: self.vContent.frame.height)
            
            }, completion: { [weak self] _ in
                guard let strongSelf = self else {
                    success?(false)
                    return }
                
                strongSelf.removeFromSuperview()
                success?(true)
        })
    }
    
    @objc func btnPhotoAlbumTapped() {
        self.hidePopUp()
        self.completionChooseAlbum?()
    }
    
    @objc func btnCameraTapped() {
        self.hidePopUp()
        self.completionChooseCamera?()
    }
    
    func showPopUp(completionChooseAlbum: CompletionClosure?, completionChooseCamera: CompletionClosure?) {
        guard let window = UIApplication.shared.keyWindow else { return }
        self.vContent.frame = window.frame
        
        self.completionChooseAlbum      = completionChooseAlbum
        self.completionChooseCamera     = completionChooseCamera
        showPopUp()
        
    }

}

//
//class NCSChoosePhotoPopUp: NCSBasePopUpView {
//    let vTop: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.white //NCSColor.whiteColor.withAlphaComponent(0.1)
//
//        return view
//    }()
//
//    let btnTitle: UIButton = {
//        let btn = UIButton()
//        btn.setAttributed(title: "Upload photo", color: UIColor.brown, font: AppFont.SF_Pro_Text_Regular.size(15.33))
//        return btn
//    }()
//
//    lazy var btnCancel: UIButton = {
//        let btn = UIButton()
//        btn.setAttributed(title: "Cancel", color: UIColor.brown, font: AppFont.SF_Pro_Text_Regular.size(15.33))
//        btn.addTarget(self, action: #selector(btnCancelTapped), for: .touchUpInside)
//        return btn
//    }()
//
//    //--- vBottom
//    let vBottom: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.white
//
//        return view
//    }()
//
//    let vStack: UIStackView = {
//        let view            = UIStackView()
//        view.distribution   = UIStackViewDistribution.fillEqually
//        view.spacing        = 10
//        view.axis           = .vertical
//        return view
//    }()
//
//    let btnMarkReview: UIButton = {
//        let btn = UIButton()
//        btn.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 5)
//        btn.setAttributed(title: "Photo Album", color: Color.whiteSmoke, font: AppFont.SF_Pro_Text_Regular.size(15.33))
//        btn.backgroundColor = Color.redGofix
//
//        return btn
//    }()
//
//    let btnMarkComplete: UIButton = {
//        let btn = UIButton()
//        btn.setBorder(borderWidth: 0, borderColor: .clear, cornerRadius: 5)
//        btn.setAttributed(title: "Camera", color: Color.whiteSmoke, font: AppFont.SF_Pro_Text_Regular.size(15.33))
//        btn.backgroundColor = Color.redGofix
//
//        return btn
//    }()
//
//    var completionChooseAlbum: CompletionClosure?
//    var completionChooseCamera: CompletionClosure?
//
//    override func setupView() {
//        super.setupView()
//
//        vContent.addSubview(vTop)
//        vTop.addSubview(btnCancel)
//        vTop.addSubview(btnTitle)
//
//        //---
//        vContent.addSubview(vBottom)
//        vBottom.addSubview(vStack)
//
//        vTop.anchor(vContent.topAnchor, left: vContent.leftAnchor, bottom: nil, right: vContent.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 41)
//
//        btnTitle.leftAnchor.constraint(equalTo: vTop.leftAnchor, constant: 20).isActive = true
//        btnTitle.centerYToSuperview()
//
//        btnCancel.rightAnchor.constraint(equalTo: vTop.rightAnchor, constant: -20).isActive = true
//        btnCancel.centerYToSuperview()
//
//        //--- vBottom
//        vBottom.anchor(vTop.bottomAnchor, left: vTop.leftAnchor, bottom: vContent.bottomAnchor, right: vTop.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//
//        vStack.anchor(vBottom.topAnchor, left: nil, bottom: vBottom.bottomAnchor, right: nil, topConstant: 37, leftConstant: 0, bottomConstant: 48, rightConstant: 0, widthConstant: 0, heightConstant: 0)
//        vStack.widthAnchor.constraint(equalTo: vBottom.widthAnchor, multiplier: 212/375).isActive = true
//        vStack.centerXToSuperview()
//
//        vStack.addArrangedSubview(btnMarkReview)
//        vStack.addArrangedSubview(btnMarkComplete)
//
//        btnMarkReview.addTarget(self, action: #selector(btnPhotoAlbumTapped), for: .touchUpInside)
//        btnMarkComplete.addTarget(self, action: #selector(btnCameraTapped), for: .touchUpInside)
//    }
//
//    func showPopUp(height: CGFloat = 0, completionChooseAlbum: CompletionClosure?, completionChooseCamera: CompletionClosure?) {
//        guard let window = UIApplication.shared.keyWindow else { return }
//        self.vContent.frame = window.frame
//
//        self.completionChooseAlbum      = completionChooseAlbum
//        self.completionChooseCamera     = completionChooseCamera
//        showPopUp(height: self.vContent.frame.height)
//
//    }
//
//    override func showPopUp(height: CGFloat = 0) {
//        guard let window = UIApplication.shared.keyWindow else { return }
//        super.showPopUp(height: self.vContent.frame.height)
//    }
//
//    @objc func btnCancelTapped() {
//        self.hidePopUp()
//    }
//
//    @objc func btnPhotoAlbumTapped() {
//        self.hidePopUp()
//        self.completionChooseAlbum?()
//    }
//
//    @objc func btnCameraTapped() {
//        self.hidePopUp()
//        self.completionChooseCamera?()
//    }
//}
