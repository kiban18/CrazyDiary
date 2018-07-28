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
    var location: String?
    
    init(id: Int, createdAt: Date, content: String, location: String?) {
        self.id = id
        self.createdAt = createdAt
        self.content = content
        self.location = location
    }
    
    func modify(modifiedAt: Date, content: String, location: String?) {
        self.modifiedAt = modifiedAt
        self.content = content
        self.location = location
    }
}
