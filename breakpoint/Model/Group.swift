//
//  Group.swift
//  breakpoint
//
//  Created by Ali Asif Zuberi on 2019-04-13.
//  Copyright © 2019 Ali Zuberi . All rights reserved.
//

import Foundation

class Group {
    private var _groupTitle: String
    private var _groupDesc: String
    private var _memberCount: Int
    private var _Key: String
    private var _memebers: [String]
    
    
    var groupTitle: String {
        return _groupTitle
    }
    
    var groupDesc: String {
        return _groupDesc
    }
    
    var memberCount: Int {
        return _memberCount
    }
    
    var Key: String{
        return _Key
    }
    
    var memebers: [String] {
        return _memebers
    }
    
    init(title: String, descritption: String, key: String, members: [String], membersCound:Int ) {
        self._groupDesc = descritption
        self._groupTitle = title
        self._Key = key
        self._memberCount = membersCound
        self._memebers = members
        
        
    }
}
