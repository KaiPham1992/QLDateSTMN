//
//  DetailProductProtocols.swift
//  BaseIOS2018
//
//  Created Ngoc Duong on 11/1/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol DetailProductWireframeProtocol: class {

}
//MARK: Presenter -
protocol DetailProductPresenterProtocol: class {

    var interactor: DetailProductInteractorInputProtocol? { get set }
    func getDetail(barCode: String)
}

//MARK: Interactor -
protocol DetailProductInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func didGetDetail(listProduct: [ProductEntity])
    
}

protocol DetailProductInteractorInputProtocol: class {

    var presenter: DetailProductInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func getDetail(barCode: String)
}

//MARK: View -
protocol DetailProductViewProtocol: class {

    var presenter: DetailProductPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
     func didGetDetail(listProduct: [ProductEntity])
}
