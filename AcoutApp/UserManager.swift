//
//  UserManager.swift
//  AcoutApp
//
//  Created by James on 9/9/18.
//

import Foundation
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class UserManager{
    static let share: UserManager = UserManager()
    
    private init() {
        
    }
    
    public func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    public func signOut() {
        try! Auth.auth().signOut()
        FBSDKLoginManager().logOut()
        GIDSignIn.sharedInstance().signOut()
        
        UIManager.goToAuthenticationController()
    }
}
