//
//  AddProductProtocols.swift
//  BaseIOS2018
//
//  Created Ngoc Duong on 11/1/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol AddProductWireframeProtocol: class {

}
//MARK: Presenter -
protocol AddProductPresenterProtocol: class {

    var interactor: AddProductInteractorInputProtocol? { get set }
    func btnAddTapped(product: ProductEntity)
}

//MARK: Interactor -
protocol AddProductInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    
    
}

protocol AddProductInteractorInputProtocol: class {

    var presenter: AddProductInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func addProduct(product: ProductEntity)
}

//MARK: View -
protocol AddProductViewProtocol: class {

    var presenter: AddProductPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}
