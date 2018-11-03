//
//  SignInStyle3ViewController.swift
//  AllStyle
//
//  Created by Coby on 3/27/18.
//  Copyright © 2018 macbook. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, SignInViewProtocol {
    
    
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
    }
    
    func setupView() {
        btnSignIn.setBorder(borderColor: .gray, cornerRadius: 10)
        vEmail.setPlaceholder(placeholder: "Email Address", color: .lightGray, font: UIFont.systemFont(ofSize: 20))
        vPassword.setPlaceholder(placeholder: "Password", color: .lightGray, font: UIFont.systemFont(ofSize: 20))
        vPassword.setSecureTextEntry()
    }
    
    @IBAction func btnSignInTapped() {
        
    }
}
