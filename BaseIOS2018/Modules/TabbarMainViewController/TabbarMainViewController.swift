//
//  TabbarMainViewController.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 11/1/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import Foundation

import UIKit

class TabbarMainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabbar()
    }
    
    private func setUpTabbar() {
        tabBar.barTintColor = .white
        tabBar.tintColor = AppColor.main
        //---
        let vcMain = HomeRouter.createModule()
        vcMain.tabBarItem = setBarItem(selectedImage: AppImage.imgHomeOn, normalImage: AppImage.imgHomeOff)
        vcMain.tabBarItem.tag = 1
        vcMain.title = "Danh Sách"
        
        let ncMain = UINavigationController(rootViewController: vcMain)
        
        //---
        let vcDetailProduct = DetailProductRouter.createModule()
        vcDetailProduct.tabBarItem = setBarItem(selectedImage: AppImage.imgCartOn, normalImage: AppImage.imgCartOff)
        vcDetailProduct.tabBarItem.tag = 2
        vcDetailProduct.title = "Chi Tiết"
        
        //---
        let vcAddProduct = AddProductRouter.createModule()
        vcAddProduct.tabBarItem = setBarItem(selectedImage: AppImage.imgListOn, normalImage: AppImage.imgListOff)
        vcAddProduct.tabBarItem.tag = 3
        vcAddProduct.title = "Thêm SP"
        
        //---
        let vcOrder = SignOutRouter.createModule()
        vcOrder.tabBarItem = setBarItem(selectedImage: AppImage.imgOrderOn, normalImage: AppImage.imgOrderOff)
        vcOrder.tabBarItem.tag = 4
        vcOrder.title = "QL Tài Khoản"
        
        //---
        self.viewControllers = [ncMain,vcDetailProduct, vcAddProduct, vcOrder]
    }
    
    private func setBarItem(selectedImage: UIImage?, normalImage: UIImage?) -> UITabBarItem {
        let item = UITabBarItem(title: nil, image: normalImage, selectedImage: selectedImage)
        
        return item
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let itemView =  self.tabBar.subviews[item.tag]
        let itemImageView = itemView.subviews.first as! UIImageView
        itemImageView.contentMode = .center
        
        self.playBounceAnimation(itemImageView)
    }
}

//Animation Tab bar
extension TabbarMainViewController {
    func playBounceAnimation(_ icon: UIImageView) {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.5)
        bounceAnimation.calculationMode = kCAAnimationCubic
        
        icon.layer.add(bounceAnimation, forKey: nil)
    }
}
