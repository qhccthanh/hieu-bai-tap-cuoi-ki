//
//  SVProgress.swift
//  AcoutApp
//
//  Created by James on 9/11/18.
//

import Foundation

import SVProgressHUD

extension SVProgressHUD {
    
    static func showError(_ text: String, duration: TimeInterval = 2, completion: (() -> ())? = nil) {
        SVProgressHUD.showError(withStatus: text)
        SVProgressHUD.dismiss(withDelay: duration) {
            completion?()
        }
    }
    
    static func showSuccess(_ text: String, duration: TimeInterval = 2, completion: (() -> ())? = nil) {
        SVProgressHUD.showSuccess(withStatus: text)
        SVProgressHUD.dismiss(withDelay: duration) {
            completion?()
        }
    }
    
}
