//
//  BaseTableCell.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 11/1/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import UIKit

class BaseTableCell: UITableViewCell {
    let vLine: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        return v
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    func setUpViews() {
        self.selectionStyle = .none
    }
    
    func addLineToBottom() {
        addSubview(vLine)
        vLine.anchor( left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
    }
}
