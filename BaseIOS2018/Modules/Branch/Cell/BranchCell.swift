//
//  BranchCell.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 11/3/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import UIKit

class BranchCell: BaseTableCell {
    
    @IBOutlet weak var lbName: UILabel!
    
    var branch: BranchEntity? {
        didSet {
            guard let _branch = branch else  { return }
            lbName.text = _branch.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbName.backgroundColor = AppColor.backgroundItem
    }
    
}
