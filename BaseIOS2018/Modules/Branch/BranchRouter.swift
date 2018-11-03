//
//  BranchRouter.swift
//  BaseIOS2018
//
//  Created Ngoc Duong on 11/3/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class BranchRouter: BranchWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = BranchViewController(nibName: nil, bundle: nil)
        let interactor = BranchInteractor()
        let router = BranchRouter()
        let presenter = BranchPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}