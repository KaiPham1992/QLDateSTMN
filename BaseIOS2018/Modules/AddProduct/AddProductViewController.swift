//
//  AddProductViewController.swift
//  BaseIOS2018
//
//  Created Ngoc Duong on 11/1/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class AddProductViewController: UIViewController, AddProductViewProtocol {

    @IBOutlet weak var lbProductCode: UILabel!
    @IBOutlet weak var tfProductCode: UITextField!
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var tfProductName: UITextField!
    @IBOutlet weak var lbAddImage: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btnAddImage: UIButton!
    @IBOutlet weak var btnAddProduct: UIButton!
    @IBOutlet weak var lbEndDay: UILabel!
    @IBOutlet weak var lbCheckDay: UILabel!
    @IBOutlet weak var lcsHeightImage: NSLayoutConstraint!
    
	var presenter: AddProductPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        //--
        btnAddImage.setBorder(cornerRadius: 3.3)
        btnAddProduct.setBorder(cornerRadius: 10)
        //--
        lcsHeightImage.constant = 0
    }
    
    //-- MARK: Action
    @IBAction func btnAddImageTapped() {
        let popUp = NCSChoosePhotoPopUp()
        let vc = SelectPhotoViewController()
        vc.delegate = self
        let nc = UINavigationController(rootViewController: vc)
        
        popUp.showPopUp(completionChooseAlbum: {
            self.present(nc, animated: true)
        }) {
            let pickedImage             = UIImagePickerController()
            pickedImage.delegate        = self
            pickedImage.sourceType      = UIImagePickerControllerSourceType.camera
            pickedImage.allowsEditing   = false
            self.present(pickedImage, animated: true)
        }
    }
    
    @IBAction func btnAddProductTapped() {
        let product = ProductEntity(id: "12345", name: "Sữa vinamilk" , dateCheck: Date().secondsSince1970, dateExpire: Date().secondsSince1970)
        
        presenter?.btnAddTapped(product: product)
    }
}

extension AddProductViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
//        if let _image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            attachmentList.append(_image)
//
//        }
//        self.dismiss(animated: true, completion: nil)
    }
}

extension AddProductViewController: SelectPhotoViewControllerDelegate {
    func didSelectedImages(images: UIImage) {
        imgProduct.image = images
        lcsHeightImage.constant = 100
        imgProduct.layoutIfNeeded()
    }
}
