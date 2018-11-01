//
//  AddProductPresenter.swift
//  BaseIOS2018
//
//  Created Ngoc Duong on 11/1/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class AddProductPresenter: AddProductPresenterProtocol, AddProductInteractorOutputProtocol {

    weak private var view: AddProductViewProtocol?
    var interactor: AddProductInteractorInputProtocol?
    private let router: AddProductWireframeProtocol

    init(interface: AddProductViewProtocol, interactor: AddProductInteractorInputProtocol?, router: AddProductWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

}
