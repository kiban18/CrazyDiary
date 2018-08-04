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
    func entry(with id: Int) -> Entry?
    func recentEntries(max: Int) -> [Entry]
}

class InMemoryDiary: Diary {
    var entries: [Int:Entry] = [:]
    
    init(entries: [Entry] = []) {
        // TODO: need to review
        var result: [Int: Entry] = [:]
        entries.forEach { entry in
            result[entry.id] = entry
        }
        self.entries = result
    }
    
    func add(_ entry: Entry) {
        entries[entry.id] = entry
    }
    
    func update(_ entry: Entry) {
        // 구조체일 경우에는 아래 코드가 필요함
        // 클래스에서도 아래 코드를 사용해도 됨
        //entries[entry.id] = entry
    }
    
    func remove(_ entry: Entry) {
        // implement 1
        entries.removeValue(forKey: entry.id)
        // implement 2
        //entries[entry.id] = nil
    }
    
    func entry(with id: Int) -> Entry? {
        return entries[id]
    }
    
    func recentEntries(max: Int) -> [Entry] {
        let result = entries
            .values
            .sorted { $0.createdAt > $1.createdAt } // 성능상 좋은 방법은 아님.
            .prefix(max) // 결과는 ArraySlice
        
//        return result
        return Array(result) // ArraySlice에서 Array를 생성
    }
}
