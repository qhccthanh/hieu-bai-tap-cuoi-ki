//
//  MessagesInfo.swift
//  AcoutApp
//
//  Created by James on 9/10/18.
//

import Foundation

class MessagesInfo {
    
    enum Content {
        case text(String?) // 0
        case image(Data?) // 1
        init?(content: [String: Any]) {
            guard let type = content["type"] as? Int else {
                return nil
            }
            
            if type == 0 {
                self = .text(content["info"] as? String)
            } else if type == 1 {
                self = .image(content["info"] as? Data)
            }
            
            return nil
        }
    }
    
    var id: String
    var content: Content
    var sentTime: Date
    var senderID: String
    
    init?(id: String, content: [String: Any], sentTime: Date, senderID: String) {
        guard let content = Content(content: content) else {
            return nil
        }
        
        self.id = id
        self.content = content
        self.senderID = senderID
        self.sentTime = sentTime
    }
    
}
