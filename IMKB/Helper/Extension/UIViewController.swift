//
//  UIViewController.swift
//  IMKB
//
//  Created by Yunus Tek on 19.05.2018.
//  Copyright © 2018 yunustek. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func getTopController() -> UIViewController{
        var topController = UIApplication.shared.keyWindow!.rootViewController! as UIViewController
        while ((topController.presentedViewController) != nil) {
            topController = topController.presentedViewController!;
        }
        return topController
    }
    
    func presentTransparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:UIBarMetrics.default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.setNavigationBarHidden(false, animated:true)
        navigationItem.hidesBackButton = true
        //                self.edgesForExtendedLayout = UIRectEdge.None // Kenarlar
        //        navCont.navigationBar.barTintColor = GlobalFunctions.shared.getColor("black")
    }
}
