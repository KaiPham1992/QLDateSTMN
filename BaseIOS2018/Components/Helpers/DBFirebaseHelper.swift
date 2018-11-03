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

typealias CompletionList = (_ listEntity: [BaseEntity]) -> Void


class DBFirebaseHelper: NSObject {
    static let shared = DBFirebaseHelper()
    let dbRoot = Database.database().reference()
    
    override init() {
        super.init()
    }
    
    func getAllBranch(completion: @escaping CompletionList){
        var listBranch = [BranchEntity]()
        dbRoot.observe(DataEventType.childAdded) { snap in
            if let value = snap.value as? String {
                let newBranch = BranchEntity(key: snap.key, name: value)
                listBranch.append(newBranch)
                completion(listBranch)
            }
        }
    }
    
    func addProduct(branch: BranchEntity, product: ProductEntity) {
        let ref = dbRoot.child(branch.key&).child(product.id&).childByAutoId()
        ref.setValue(product.toJSON())
    }
    
    func login(email: String, password: String) {
        try? Auth.auth().signOut()
//        Auth.auth().signIn(withEmail: "ngocduong2310@gmail.com", password: "12345678") { (user, error) in
//           // print(user?.user.email)
//
//
//        }
        
//        self.refSTMN.observe(DataEventType.childAdded, with: { (data) in
//            print(data.key)
//            print(data.value)
//        })
    }
}
