//
//  ProgressView.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/2/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import UIKit

open class ProgressView {
    
    var vcontainer: UIView = {
        let v = UIView()
        
        return v
    }()
    
    var vProgress: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return v
    }()
    
    var activityIndicator: KActivityIndicatorView = {
        let view = KActivityIndicatorView(type: KActivityIndicatorType.ballSpinFadeLoader)
        
        return view
    }()
    
    public static let shared = ProgressView()
    
    private func showProgressView(_ view: UIView) {
    
        view.addSubview(vcontainer)
        vcontainer.fillSuperview()
        
        vcontainer.addSubview(vProgress)
        vProgress.centerSuperview()
        vProgress.anchor(widthConstant: 100, heightConstant: 100)
        vProgress.setBorder(cornerRadius: 5)
        
        vProgress.addSubview(activityIndicator)
        activityIndicator.centerSuperview()
        
        activityIndicator.anchor(widthConstant: KActivityIndicatorView.DEFAULT_BLOCKER_SIZE.width, heightConstant: KActivityIndicatorView.DEFAULT_BLOCKER_SIZE.height)
    
        activityIndicator.startAnimating()
    }
    
    open func showProgress() {
        DispatchQueue.main.async {
            guard let view = UIApplication.topViewController()?.view else { return }
            self.showProgressView(view)
        }
    }
    
    open func hideProgressView() {
        DispatchQueue.main.async {
            self.vcontainer.removeFromSuperview()
            self.vProgress.removeFromSuperview()
            self.activityIndicator.removeFromSuperview()
        }
        
    }
}

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
}
