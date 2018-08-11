//
//  CrazyDiaryTests.swift
//  CrazyDiaryTests
//
//  Created by LeeKihwan on 28/07/2018.
//  Copyright © 2018 Crazy Up Inc. All rights reserved.
//

import XCTest
import Nimble
@testable import CrazyDiary

extension Entry {
    static var dayBeforeYesterday: Entry { return Entry(createdAt: Date.distantPast, text: "그저께 일기") }
    static var yesterday: Entry { return Entry(createdAt: Date(), text: "어제 일기") }
    static var today: Entry { return Entry(createdAt: Date.distantFuture, text: "오늘 일기") }
}

class CrazyDiaryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // 첫 번째 단위 테스트
    func testEditEntryText() {
        // Setup
        let newEntry = Entry.init(text: "오늘은 기분이 좋다.", location: "서울")

        // Run
        newEntry.text = "오늘은 기분이 좋다.."
        
        // Verify
        XCTAssertEqual(newEntry.text, "오늘은 기분이 좋다..")
        // Teardown
        // TODO 위에 생성한 엔트리 삭제!

    }
    
    // 일기장에 일기 추가
    func testAddEntryToDiary() {
        // Setup
        let diary = InMemoryDiary()
        let id = UUID()
        let newEntry = Entry(id: id, text: "일기", location: "대구")

        // Run
        diary.add(newEntry)
        
        // Verify
        let entryInJournal: Entry? = diary.entry(with: id)
        
        XCTAssertEqual(entryInJournal, .some(newEntry)) // need Equatable
        XCTAssertTrue(entryInJournal === newEntry) // // 클래스 타입에만 사용 가능, 같은 데이터인지?
        XCTAssertTrue(entryInJournal?.isIdentical(to: newEntry) == true)
    }
    
    // 일기장에서 일기 가져오기
    func testGetEntryWithId() {
        // Setup
        let id = UUID()
        let oldEntry = Entry(id: id, text: "일기")
        let diary = InMemoryDiary(entries: [oldEntry])
        
        // Run
        let entry = diary.entry(with: id)
        
        // Verify
        XCTAssertEqual(entry, .some(oldEntry))
        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
    }
    
    // 일기장에 일기 업데이트 하기
    func testUpdateEntryPositive() {
        // Setup
        let id = UUID()
        let oldEntry = Entry(id: id, text: "일기")
        let diary = InMemoryDiary(entries: [oldEntry])
        
        // Run
        oldEntry.text = "일기 내용을 수정했습니다."
        diary.update(oldEntry)
        
        // Verify
        let entry = diary.entry(with: id)
        XCTAssertEqual(entry, .some(oldEntry)) // TODO: 어떤 의미?
        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
        XCTAssertEqual(entry?.text, .some("일기 내용을 수정했습니다."))
    }
    
    // 일기장에 일기 업데이트 하기 - negative
    func testUpdateEntryNegative() {
        // Setup
        let id = UUID()
        let oldEntry = Entry(id: id, text: "일기")
        let diary = InMemoryDiary(entries: [oldEntry])
        
        // Run
        oldEntry.text = "일기 내용을 수정했습니다."
        diary.update(oldEntry)
        
        // Verify
        let entry = diary.entry(with: id)
        XCTAssertEqual(entry, .some(oldEntry)) // TODO: 어떤 의미?
        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
        XCTAssertNotEqual(entry?.text, .some("일기 내용이 달라졌어요."))
    }

    // 일기장에서 일기 지우기
    func testRemoveEntry() {
        // Setup
        let id = UUID()
        let oldEntry = Entry(id: id, text: "지워질 일기")
        let diary = InMemoryDiary(entries: [oldEntry])
        
        // Run
        diary.remove(oldEntry)
        
        // Verify
        let entry = diary.entry(with: id)
        XCTAssertNil(entry)
    }
    
    // 일기장에서 최근 작성된 순으로 일기 가져오기
    func testGetRecentEntriesByDateDescending() {
        // Setup
        let dayBeforeYesterday = Entry.dayBeforeYesterday
        let yesterday = Entry.yesterday
        let today = Entry.today
        let diary = InMemoryDiary(entries: [dayBeforeYesterday, yesterday, today])
//        let diary = InMemoryDiary(entries: [Entry.dayBeforeYesterday, Entry.yesterday, Entry.today])

        // Run
        let entries = diary.recentEntries(max: 3)
        
        // Verify
        XCTAssertEqual(entries.count, 3)
        XCTAssertEqual(entries, [today, yesterday, dayBeforeYesterday])
//        XCTAssertEqual(entries, [Entry.today, Entry.yesterday, Entry.dayBeforeYesterday])
    }
    
    // 일기장에서 최근 작성된 순으로 정해진 수 만큼 일기 가져오기
    func testGetRecentEntriesByMaxCount() {
        // Setup
        let diary = InMemoryDiary(entries: [Entry.dayBeforeYesterday, Entry.yesterday, Entry.today])
        
        // Run
        let entries = diary.recentEntries(max: 1)
        
        // Verify
        XCTAssertEqual(entries.count, 1)
        XCTAssertEqual(entries, [Entry.today])
    }
    
    func testGetRecentEntriesAsManyAsStored() {
        // Setup
        let diary = InMemoryDiary(entries: [Entry.dayBeforeYesterday, Entry.yesterday, Entry.today])
        
        // Run
        let entries = diary.recentEntries(max: 10)
//        let entries = diary.recentEntries(max: -3)

        // Verify
        XCTAssertEqual(entries.count, 3)
        XCTAssertEqual(entries, [Entry.today, Entry.yesterday, Entry.dayBeforeYesterday])
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
