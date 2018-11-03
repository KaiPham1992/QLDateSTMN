//
//  SelectPhotoViewController.swift
//  GoFixCustomer
//
//  Created by Kai Pham on 9/11/18.
//  Copyright © 2018 gofix.vinova.sg. All rights reserved.
//

import UIKit
import Photos
import Foundation

protocol SelectPhotoViewControllerDelegate: class {
    func didSelectedImages(images: UIImage)
}

class SelectPhotoViewController: UIViewController {
    
    lazy var cvPhotos: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.alwaysBounceVertical = true
        
        return cv
    }()
    
    internal var collectionViewLayout: UICollectionViewLayout!
    
    weak var delegate: SelectPhotoViewControllerDelegate?
    
    var photos: [UIImage] = []
    var photosSelected = UIImage()
    var photoAssets: PHFetchResult<PHAsset> = PHFetchResult()
    
    open let pageSize = Int(Int64())
    
    var numberMaxPhoto: Int = 10
    
    internal lazy var fetchOptions: PHFetchOptions = {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return fetchOptions
    }()
    
    internal var fetchLimit: Int {
        get {
            return fetchOptions.fetchLimit
        }
        set {
            fetchOptions.fetchLimit = newValue
        }
    }
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        setUp()
        Utils.checkPhotoLibraryPermission()
        setUpView()
        configureCollection()
        addRightNavigationItem()
    }
    
    func addRightNavigationItem() {
        let rightButtonItem = UIBarButtonItem.init(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(self.btnDoneTapped)
        )
        self.navigationItem.rightBarButtonItem = rightButtonItem
        self.navigationItem.rightBarButtonItem?.tintColor = .orange
        
    }
    
    func setUpView(){
        self.view.addSubview(cvPhotos)
        cvPhotos.fillSuperview()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Upload Photo"
    }
    
    fileprivate func setUp() {
        requestPhotoAccessIfNeeded(PHPhotoLibrary.authorizationStatus())
        fetchOptions.fetchLimit = pageSize
        photoAssets = PHAsset.fetchAssets(with: fetchOptions)
        collectionViewLayout = cvPhotos.collectionViewLayout
    }
    
    func configureCollection(){
        cvPhotos.register(SelectPhotoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func getSelectedPhotosFromAsset(completed: @escaping () -> Void) {
        let indexPathsForSelectedItems = cvPhotos.indexPathsForSelectedItems ?? []
        var photoAssets: [PHAsset] = []
        for indexPath in indexPathsForSelectedItems {
            guard indexPath.item < self.photoAssets.count else { continue }
            photoAssets += [self.photoAssets.object(at: indexPath.item)]
        }
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isSynchronous = false
        options.isNetworkAccessAllowed = true
        
        var completedCount = 0
        for photoAsset in photoAssets {
            let size = CGSize(width: 400, height: 400)
            PHImageManager.default().requestImage(for: photoAsset, targetSize: size, contentMode: .aspectFill, options: options, resultHandler: {(result, info) in
                if let image = result {
//                    self.photosSelected.append(image.resizeImage(maxWidth: MaxWidthImage))
                    self.photosSelected = image.resizeImage(maxWidth: MaxWidthImage)
                    completedCount += 1
                }
                if completedCount == photoAssets.count {
                    completed()
                }
            })
        }
    }
    
    fileprivate func fetchNextPageIfNeeded(indexPath: IndexPath) {
        guard indexPath.item == fetchLimit-1 else { return }
        
        let oldFetchLimit = fetchLimit
        fetchLimit += pageSize
        photoAssets = PHAsset.fetchAssets(with: fetchOptions)
        
        var indexPaths: [IndexPath] = []
        for i in oldFetchLimit..<photoAssets.count {
            indexPaths += [IndexPath(item: i, section: 0)]
        }
        cvPhotos.insertItems(at: indexPaths)
    }
    
    fileprivate func requestPhotoAccessIfNeeded(_ status: PHAuthorizationStatus) {
        guard status == .notDetermined else { return }
        PHPhotoLibrary.requestAuthorization { [weak self] (authorizationStatus) in
            DispatchQueue.main.async { [weak self] in
                self?.photoAssets = PHAsset.fetchAssets(with: self?.fetchOptions)
                self?.cvPhotos.reloadData()
            }
        }
    }
}

extension SelectPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func configCollectionView() {
        cvPhotos.allowsMultipleSelection = true
        cvPhotos.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoAssets.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let layoutAttributes = collectionViewLayout?.layoutAttributesForItem(at: indexPath),
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SelectPhotoCollectionViewCell else { return UICollectionViewCell() }
        
        let photoAsset = photoAssets.object(at: indexPath.item)
        cell.photoAsset = photoAsset
        cell.size = layoutAttributes.frame.size
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width - 2) / 3, height: (self.view.frame.size.width - 2) / 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let indexPathsForSelectedItems = cvPhotos.indexPathsForSelectedItems {
            if indexPathsForSelectedItems.count > numberMaxPhoto {
                if let cell = collectionView.cellForItem(at: indexPath) {
                    cell.isSelected = false
                    collectionView.reloadItems(at: [indexPath])
//                    NBUtils.showAlert(title: NBMessage.fullPhoto)
                }
            }
        }
    }
}

//MARK: Action
extension SelectPhotoViewController {
     @objc func btnDoneTapped() {
        
        getSelectedPhotosFromAsset {
            self.delegate?.didSelectedImages(images: self.photosSelected)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
