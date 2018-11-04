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
import ObjectMapper

typealias CompletionList = (_ listEntity: [BaseEntity]) -> Void

class DBFirebaseHelper: NSObject {
    static let shared = DBFirebaseHelper()
    let dbRoot = Database.database().reference()
    
    var listBranch = [
        BranchEntity(key: "TANTIEN", name: "Tân Tiến - Tân Văn"),
        BranchEntity(key: "DADON", name: "Đạ Đờn - Lâm Hà")
    ]
    
    var branchMain = BranchEntity(key: "TANTIEN", name: "Tân Tiến - Tân Văn")
    
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
        if !checkInternet() {
            return
        }
        
        let branch = branchMain
        let ref = dbRoot.child(branch.key&).child("PRODUCT").child(product.id&).childByAutoId()
        ref.setValue(product.toJSON())
        ref.removeAllObservers()
        ref.observe(.value) { _ in
            PopUpHelper.shared.showMessage(message: "Thêm thành công!")
        }
    }
    
    func checkInternet() -> Bool {
        if Connectivity.isConnectedToInternet() {
            return true
        } else {
            PopUpHelper.shared.showMessage(message: "Không có internet!")
            return false
        }
    }
    
    func getDetailProduct(id: String, completion: @escaping CompletionList) {
        if !checkInternet() {
            return
        }
        
        var listProduct = [ProductEntity]()
        
        let ref = dbRoot.child(branchMain.key&).child("PRODUCT").child(id)
        ref.observe(.childAdded) { data in
            if let _product = Mapper<ProductEntity>().map(JSONObject: data.value) {
                _product.id = id
                _product.expireId = data.key // id is ID date expire
                listProduct.append(_product)
            }
            listProduct = listProduct.sorted(by: { _product1, _product2 -> Bool in
                if let _dateCheck1 = _product1.dateCheck,let _dateCheck2 = _product2.dateCheck {
                    return _dateCheck1 < _dateCheck2
                }
                
                return true
                
            })
            completion(listProduct)
        }
    }
    
    // use in home
    func getProductNeedCheck(completion: @escaping CompletionList) {
        
        if !checkInternet() {
            return
        }
        
        
        var listProduct = [ProductEntity]()
        let ref = dbRoot.child(branchMain.key&).child("PRODUCT")
        
        ref.observe(.childAdded) { data in
            let refDate = ref.child(data.key).queryEnding(atValue: "\(Date().secondsSince1970)", childKey: "date_check")
            
            refDate.observe(.childAdded, with: { snapDate in
                if let product = Mapper<ProductEntity>().map(JSONObject: snapDate.value) {
                    product.id = data.key
                    listProduct.append(product)
                }
                
                let listAfterRemoveDuplicate = self.removeDuplicate(listProduct: listProduct)
                
                completion(listAfterRemoveDuplicate)
            })
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

extension DBFirebaseHelper {
    func removeDuplicate(listProduct: [ProductEntity]) -> [ProductEntity] {
        var newList = [ProductEntity]()
        listProduct.forEach { _product in
            if !isContaintProduct(listProduct: newList, key: _product.id&) {
                newList.append(_product)
            }
        }
        
        return newList
    }
    
    func isContaintProduct(listProduct: [ProductEntity], key: String) -> Bool {
        var count = 0
        listProduct.forEach { _product in
            if _product.id& == key {
                count += 1
            }
        }
       return count >= 1
    }
}
