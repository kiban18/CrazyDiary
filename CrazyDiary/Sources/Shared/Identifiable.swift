//
//  Identifiable.swift
//  CrazyDiary
//
//  Created by LeeKihwan on 04/08/2018.
//  Copyright © 2018 Crazy Up Inc. All rights reserved.
//

import Foundation

protocol Identifiable {
    var id: UUID { get }
}

extension Identifiable {
    func isIdentical(to other: Self) -> Bool {
        return id == other.id
    }
}
