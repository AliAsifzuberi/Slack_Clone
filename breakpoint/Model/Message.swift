//
//  Message.swift
//  breakpoint
//
//  Created by Ali Zuberi  on 2018-12-15.
//  Copyright © 2018 Ali Zuberi . All rights reserved.
//

import Foundation
import Firebase

class Message {
    private var _content: String
    private var _senderID: String
    
    var content: String {
        return _content
    }
    
    var senderID: String {
        return _senderID
    }
    init(content: String, senderID: String) {
        self._content = content
        self._senderID = senderID
    }
    
  
}
