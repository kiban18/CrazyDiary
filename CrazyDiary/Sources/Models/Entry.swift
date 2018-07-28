//
//  Entry.swift
//  CrazyDiary
//
//  Created by LeeKihwan on 28/07/2018.
//  Copyright © 2018 Crazy Up Inc. All rights reserved.
//

import Foundation

class Entry {
    let id: Int
    let createdAt: Date
    var modifiedAt: Date?
    var content: String
    
    init(id: Int, createdAt: Date, content: String) {
        self.id = id
        self.createdAt = createdAt
        self.content = content
    }
    
    func modify(modifiedAt: Date, content: String) {
        self.modifiedAt = modifiedAt
        self.content = content
    }
}
