//
//  UIManager.swift
//  AcoutApp
//
//  Created by James on 9/12/18.
//

import Foundation
import UIKit

class UIManager {
    
    static func goToAuthenticatedController() {
        let mainTabBarController = MainTabViewController()
        UIApplication.shared.keyWindow?.rootViewController = mainTabBarController
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
    
    static func goToAuthenticationController() {
        let vc = ViewController()
        UIApplication.shared.keyWindow?.rootViewController = vc
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
}
