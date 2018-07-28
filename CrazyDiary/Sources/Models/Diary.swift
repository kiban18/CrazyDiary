//
//  Diary.swift
//  CrazyDiary
//
//  Created by LeeKihwan on 28/07/2018.
//  Copyright © 2018 Crazy Up Inc. All rights reserved.
//

import Foundation

protocol Diary {
    func add(_ entry: Entry)
    func update(_ entry: Entry)
    func remove(_ entry: Entry)
    func recentEntries(max: Int) -> [Entry]
}
