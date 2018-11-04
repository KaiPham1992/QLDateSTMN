//
//  ProductCell.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 11/1/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import UIKit

class ProductCell: BaseTableCell {
    
    @IBOutlet weak var lbBarcode: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDateCheck: UILabel!
    @IBOutlet weak var lbExpireDate: UILabel!
    @IBOutlet weak var lbOrder: UILabel!
    
    var product: ProductEntity? {
        didSet {
            guard let _product = product else { return }
            lbBarcode.text = "Mã vạch: \(_product.id&)"
            lbName.text = _product.name
            
            if let dateCheck = _product.dateCheck {
                let dateNeedCheck = Date(seconds: dateCheck).toString(formatString: AppDateFormat.ddMMyyyy.rawValue)
                lbDateCheck.text = "Ngày đi kiểm tra: \(dateNeedCheck)"
            }
            
            if let dateExpire = _product.dateExpire {
                let dateNeedCheck = Date(seconds: dateExpire).toString(formatString: AppDateFormat.ddMMyyyy.rawValue)
                lbExpireDate.text = "Ngày hết hạn: \(dateNeedCheck)"
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
         addLineToBottom()
    }
}
