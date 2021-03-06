//
//  BranchInteractor.swift
//  BaseIOS2018
//
//  Created Ngoc Duong on 11/3/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class BranchInteractor: BranchInteractorInputProtocol {
    func getBranch() {
        self.presenter?.didGetBranch(listBranch: DBFirebaseHelper.shared.listBranch)
    }
    
    weak var presenter: BranchInteractorOutputProtocol?
}
