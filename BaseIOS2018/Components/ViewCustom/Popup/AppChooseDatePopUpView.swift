//
//  File.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 11/3/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import Foundation

import UIKit

protocol NCSChooseDatePopUpViewDelegate: class {
    func selectedDate(date: Date)
}

class AppChooseDatePopUpView: NCSBasePopUpView {
    static let shared = AppChooseDatePopUpView()
    
    let vTop: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        
        return view
    }()
    
    let vBottom: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.main
        
        return view
    }()
    
    let datePicker: UIDatePicker = {
        let date = UIDatePicker()
        date.datePickerMode = UIDatePickerMode.date
        date.setValue(AppColor.white, forKey: "textColor")
        
        return date
    }()
    
    let btnDone: UIButton = {
        let btn = UIButton()
        btn.setAttributed(title: "Done", color: AppColor.white, font: btn.titleLabel?.font!)
        btn.addTarget(self, action: #selector(btnDoneTapped), for: .touchUpInside)
        
        return btn
    }()
    
    weak var delegate: NCSChooseDatePopUpViewDelegate?
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(vTop)
        vTop.addSubview(btnDone)
        
        //---
        vContent.addSubview(vBottom)
        vBottom.addSubview(datePicker)
        
        vTop.anchor(vContent.topAnchor, left: vContent.leftAnchor, bottom: nil, right: vContent.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 41)
        
        btnDone.rightAnchor.constraint(equalTo: vTop.rightAnchor, constant: -20).isActive = true
        btnDone.centerYToSuperview()
        
        vBottom.anchor(vTop.bottomAnchor, left: vTop.leftAnchor, bottom: vContent.bottomAnchor, right: vTop.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        datePicker.fillSuperview()
    }
    
    func showPopUp(minDate: Date? = nil, maxDate: Date? = nil, currentDate: Date? = nil) {
        showPopUp()
        var min =  Date()
        if minDate != nil {
            min = minDate!
        }
        self.datePicker.minimumDate = min
        self.datePicker.maximumDate = maxDate
        
        if currentDate != nil {
            self.datePicker.setDate(currentDate!, animated: true)
        }
        
    }
    
    @objc func btnDoneTapped() {
        self.hidePopUp()
        let dateSelected = datePicker.date
        delegate?.selectedDate(date: dateSelected)
    }
}
