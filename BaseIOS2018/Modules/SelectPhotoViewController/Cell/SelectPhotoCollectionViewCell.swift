//
//  SelectPhotoCollectionViewCell.swift
//  GoFixCustomer
//
//  Created by Kai Pham on 9/11/18.
//  Copyright © 2018 gofix.vinova.sg. All rights reserved.
//

import UIKit
import Photos

class SelectPhotoCollectionViewCell: UICollectionViewCell {
    let imgPhoto: UIImageView = {
        let img = UIImageView()
        
        return img
    }()
    
    let imgSelected: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "check")
        img.isHidden = true
        return img
    }()
    
    static let scale: CGFloat = 3
    
    var photoAsset: PHAsset? {
        didSet {
            loadIfNeeded()
        }
    }
    
    var size: CGSize? {
        didSet {
            loadIfNeeded()
        }
    }
    
    fileprivate var imageRequestID: PHImageRequestID?
    
    override var isSelected: Bool  {
        set {
            super.isSelected = newValue
            self.imgSelected.isHidden = !newValue
        }
        get {
            return super.isSelected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
     func setupViews() {
        
        //---
        self.addSubview(imgPhoto)
        self.addSubview(imgSelected)
        imgPhoto.fillSuperview()
        
        imgSelected.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 0, heightConstant: 0)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgPhoto.image =  #imageLiteral(resourceName: "haohao")
        
        //Cancel request if needed
        let manager = PHImageManager.default()
        guard let imageRequestID = self.imageRequestID else { return }
        manager.cancelImageRequest(imageRequestID)
        self.imageRequestID = nil
    }
    
    fileprivate func loadIfNeeded() {
        guard let asset = photoAsset, let size = self.size else { return }
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        options.isSynchronous = false
        options.isNetworkAccessAllowed = true
        
        let manager = PHImageManager.default()
        let newSize = CGSize(width: size.width * type(of: self).scale,
                             height: size.height * type(of: self).scale)
        
        imageRequestID = manager.requestImage(for: asset, targetSize: newSize, contentMode: .aspectFill, options: options, resultHandler: { [weak self] (result, info) in
            
            self?.imageRequestID = nil
            guard let result = result else {
                self?.imgPhoto.image = #imageLiteral(resourceName: "check")
                return
            }
            self?.imgPhoto.image = result
        })
    }
}
