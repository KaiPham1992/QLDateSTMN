//
//  SignInStyle3ViewController.swift
//  AllStyle
//
//  Created by Coby on 3/27/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController, SignInViewProtocol {
    @IBOutlet weak var lbAppName: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var vEmail: TextFieldNewStyleView!
    @IBOutlet weak var vPassword: TextFieldNewStyleView!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    var presenter: SignInPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        vEmail.tfInput.text = "ngocduong2310@gmail.com"
        vPassword.tfInput.text = "12345678"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setupView() {
        btnSignIn.setBorder(borderColor: .gray, cornerRadius: 10)
        vEmail.setPlaceholder(placeholder: "Nhập email", color: .lightGray, font: UIFont.systemFont(ofSize: 20))
        vPassword.setPlaceholder(placeholder: "Nhập mật khẩu", color: .lightGray, font: UIFont.systemFont(ofSize: 20))
        vPassword.setSecureTextEntry()
    }
    
    @IBAction func btnSignInTapped() {
        DBFirebaseHelper.shared.login(email: vEmail.tfInput.text&, password: vPassword.tfInput.text&, completion: {
            self.presenter?.goToBranch()
        })
    }
}
