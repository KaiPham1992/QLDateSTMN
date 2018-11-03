//
//  TextFieldNewStyleView.swift
//  AllStyle
//
//  Created by Coby on 3/27/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class TextFieldNewStyleView: UIView {
    
    @IBOutlet weak var tfInput: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        let nib = UINib(nibName: "TextFieldNewStyleView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        addSubview(view)
        //--
        self.setBorder(borderWidth: 0.5, borderColor: .white, cornerRadius: 10)
        
    }
    func setPlaceholder(placeholder: String,color: UIColor = UIColor.lightGray, font: UIFont? = nil) {
        let tempFont = font == nil ? self.tfInput.font: font!
        guard let _tempFont = tempFont else { return }
        tfInput.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedStringKey.font: _tempFont , NSAttributedStringKey.foregroundColor: color])
    }
    
    func setSecureTextEntry() {
        tfInput.isSecureTextEntry = true
    }
}
