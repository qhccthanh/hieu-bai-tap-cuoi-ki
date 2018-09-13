//
//  UserInfo.swift
//  AcoutApp
//
//  Created by James on 9/10/18.
//

import Foundation

class UserInfo {
    var id: String
    var name: String?
    var email: String?
    var avatar: String?
    var dialogIDs: [String] = []
    var status: Int = 0
    
    init(id: String) {
        self.id = id
    }
}

