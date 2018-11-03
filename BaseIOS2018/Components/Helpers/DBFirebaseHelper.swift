//
//  DBFirebaseHelper.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 11/3/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth
import Alamofire

typealias CompletionList = (_ listEntity: [BaseEntity]) -> Void

class DBFirebaseHelper: NSObject {
    static let shared = DBFirebaseHelper()
    let dbRoot = Database.database().reference()
    
    var branchMain = BranchEntity(key: "TAN_TIEN", name: "TAN_TIEN")
    
    override init() {
        super.init()
    }
    
    func getAllBranch(completion: @escaping CompletionList){
        var listBranch = [BranchEntity]()
        dbRoot.observe(DataEventType.childAdded) { snap in
            let newBranch = BranchEntity(key: snap.key, name: snap.key)
            listBranch.append(newBranch)
            completion(listBranch)
        }
    }
    
    func addProduct(product: ProductEntity) {
        let branch = branchMain
        if Connectivity.isConnectedToInternet() {
            let ref = dbRoot.child(branch.key&).child("PRODUCT").child(product.id&).childByAutoId()
            ref.setValue(product.toJSON())
            ref.removeAllObservers()
            ref.observe(.value) { _ in
                PopUpHelper.shared.showMessage(message: "Thêm thành công!")
            }
        } else {
            PopUpHelper.shared.showMessage(message: "Không có internet!")
        }
        
    }
    
    func login(email: String, password: String, completion: @escaping CompletionClosure) {
        ProgressView.shared.showProgress()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            ProgressView.shared.hideProgressView()
            if error != nil {
                PopUpHelper.shared.showMessage(message: error!.localizedDescription)
            } else {
                completion()
            }
        }
    }
}
