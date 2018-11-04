//
//  SignOutPresenter.swift
//  BaseIOS2018
//
//  Created Ngoc Duong on 11/4/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SignOutPresenter: SignOutPresenterProtocol, SignOutInteractorOutputProtocol {

    weak private var view: SignOutViewProtocol?
    var interactor: SignOutInteractorInputProtocol?
    private let router: SignOutWireframeProtocol

    init(interface: SignOutViewProtocol, interactor: SignOutInteractorInputProtocol?, router: SignOutWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
