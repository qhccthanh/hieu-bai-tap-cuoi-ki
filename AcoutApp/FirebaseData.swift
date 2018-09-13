//
//  FirebaseData.swift
//  AcoutApp
//
//  Created by James on 9/10/18.
//

import Foundation

import FirebaseDatabase

class FirebaseData {
    
    static let shared: FirebaseData = FirebaseData()
    let ref: DatabaseReference
    
    var userRef: DatabaseReference {
        return ref.child("users")
    }
    
    private init() {
        ref = Database.database().reference().child("hellofire")
    }
    
}
