//
//  Entry.swift
//  CrazyDiary
//
//  Created by LeeKihwan on 28/07/2018.
//  Copyright © 2018 Crazy Up Inc. All rights reserved.
//

import Foundation

class Entry {
    let id: UUID
    let createdAt: Date
    var modifiedAt: Date?

    var text: String {
        didSet {
            self.modifiedAt = Date()
        }
    }
    
    var location: String? {
        didSet {
            self.modifiedAt = Date()
        }
    }
    
    init(id: UUID = UUID(), createdAt: Date = Date(), text: String, location: String? = nil) {
        self.id = id
        self.createdAt = createdAt
        self.text = text
        self.location = location
    }
    
    func description() {
    }
}

extension Entry: Identifiable { }

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        guard lhs.id == rhs.id else { return false }
        guard lhs.createdAt == rhs.createdAt else { return false }
        guard lhs.text == rhs.text else { return false }
        //guard lhs.location == rhs.location else { return false }
        
        return true
    }
}
