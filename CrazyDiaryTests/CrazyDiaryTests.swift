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
    static var dayBeforeYesterday: Entry { return Entry(id: 1, createdAt: Date.distantPast, text: "그저께 일기") }
    static var yesterday: Entry { return Entry(id: 2, createdAt: Date(), text: "어제 일기") }
    static var today: Entry { return Entry(id: 3, createdAt: Date.distantFuture, text: "오늘 일기") }
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
        let newEntry = Entry.init(id: 0, createdAt: Date(), text: "오늘은 기분이 좋다.", location: "서울")

        // Run
        newEntry.text = "오늘은 기분이 좋다.."
        
        // Verify
//        XCTAssertEqual(newEntry.text, "오늘은 기분이 좋다..")
        expect(newEntry.text).to(equal("오늘은 기분이 좋다.."))
        expect(newEntry.location) == "서울" // Nimble Operator Overloads
        // Teardown
        // TODO 위에 생성한 엔트리 삭제!

    }
    
    // 일기장에 일기 추가
    func testAddEntryToDiary() {
        // Setup
        let diary = InMemoryDiary()
        let newEntry1 = Entry(id: 1, createdAt: Date(), text: "일기", location: "대구")
        let newEntry2 = Entry(id: 2, createdAt: Date(), text: "일기", location: "대구")

        // Run
        diary.add(newEntry1)
        diary.add(newEntry2)

        // Verify
        let entryInJournal1: Entry? = diary.entry(with: 1)
        let entryInJournal2: Entry? = diary.entry(with: 2)

//        XCTAssertEqual(entryInJournal1, .some(newEntry1)) // need Equatable
        expect(entryInJournal1) == newEntry1
        expect(entryInJournal1) == .some(newEntry1) // What is difference between newEntry1 and .some(newEntry1) ?
        expect(entryInJournal2) != newEntry1 // NOT equal to
        expect(entryInJournal2) == newEntry2 // equal to

//        XCTAssertTrue(entryInJournal1 === newEntry1) // 클래스 타입에만 사용 가능?, 같은 데이터인지?
//        XCTAssertTrue(entryInJournal1?.isIdentical(to: newEntry1) == true)
        expect(entryInJournal1) === newEntry1 // identical to
        expect(entryInJournal2) !== newEntry1 // NOT identical to
        expect(entryInJournal2) === newEntry2 // identical to
    }
    
    // 일기장에서 일기 가져오기
    func testGetEntryWithId() {
        // Setup
        let oldEntry = Entry(id: 1, createdAt: Date(), text: "일기")
        let diary = InMemoryDiary(entries: [oldEntry])
        
        // Run
        let entry = diary.entry(with: 1)
        
        // Verify
//        XCTAssertEqual(entry, .some(oldEntry))
        expect(entry) == oldEntry
//        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
        expect(entry) === oldEntry
    }
    
    // 일기장에 일기 업데이트 하기
    func testUpdateEntryPositive() {
        // Setup
        let oldEntry = Entry(id: 1, createdAt: Date(), text: "일기")
        let diary = InMemoryDiary(entries: [oldEntry])
        
        // Run
        oldEntry.text = "일기 내용을 수정했습니다."
        diary.update(oldEntry)
        
        // Verify
        let entry = diary.entry(with: 1)
//        XCTAssertEqual(entry, .some(oldEntry))
        expect(entry) == oldEntry
//        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
        expect(entry?.isIdentical(to: oldEntry)).to(beTrue())
        expect(entry) === oldEntry
//        XCTAssertEqual(entry?.text, .some("일기 내용을 수정했습니다."))
        expect(entry?.text) == "일기 내용을 수정했습니다."

        let entry2 = diary.entry(with: 2)
        //expect(entry2?.text) != "일기 내용을 수정했습니다."
        expect(entry2?.text).to(beNil())
    }
    
    // 일기장에 일기 업데이트 하기 - negative
    func testUpdateEntryNegative() {
        // Setup
        let oldEntry = Entry(id: 1, createdAt: Date(), text: "일기")
        let diary = InMemoryDiary(entries: [oldEntry])
        
        // Run
        oldEntry.text = "일기 내용을 수정했습니다."
        diary.update(oldEntry)
        
        // Verify
        let entry = diary.entry(with: 1)
//        XCTAssertEqual(entry, .some(oldEntry))
        expect(entry) == oldEntry
//        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
        expect(entry) === oldEntry
//        XCTAssertNotEqual(entry?.text, .some("일기 내용이 달라졌어요."))
        expect(entry?.text) != "일기"
        expect(entry?.text) != "일기 내용이 달라졌어요."
    }

    // 일기장에서 일기 지우기
    func testRemoveEntry() {
        // Setup
        let oldEntry = Entry(id: 2, createdAt: Date(), text: "지워질 일기")
        let diary = InMemoryDiary(entries: [oldEntry])
        
        // Run
        diary.remove(oldEntry)
        
        // Verify
        let entry = diary.entry(with: 2)
//        XCTAssertNil(entry)
        expect(entry).to(beNil())
    }
    
    // 일기장에서 최근 작성된 순으로 일기 가져오기
    func testGetRecentEntriesByDateDescending() {
        // Setup
        let diary = InMemoryDiary(entries: [Entry.dayBeforeYesterday, Entry.yesterday, Entry.today])
        print("1. dayBeforeYesterday: \(Entry.dayBeforeYesterday.createdAt)")
        print("2. yesterday: \(Entry.yesterday.createdAt)")
        print("3. today: \(Entry.today.createdAt)")
//        1. dayBeforeYesterday: 0000-12-30 00:00:00 +0000
//        2. yesterday: 2018-08-08 04:00:55 +0000
//        3. today: 4001-01-01 00:00:00 +0000
        
        // Run
        let entries = diary.recentEntries(max: 3)
        entries.forEach { print($0.createdAt) }
//        4001-01-01 00:00:00 +0000
//        2018-08-08 04:00:55 +0000
//        0000-12-30 00:00:00 +0000
        
        // Verify
//        XCTAssertEqual(entries.count, 3)
        expect(entries.count) == 3
        XCTAssertEqual(entries, [Entry.today, Entry.yesterday, Entry.dayBeforeYesterday])
        expect(entries) == [Entry.today, Entry.yesterday, Entry.dayBeforeYesterday]
        
        let expectedEntries = [Entry.today, Entry.yesterday, Entry.dayBeforeYesterday]
        expectedEntries.forEach { print($0.createdAt) }
//        4001-01-01 00:00:00 +0000
//        2018-08-08 04:00:55 +0000
//        0000-12-30 00:00:00 +0000
    }
    
    // 일기장에서 최근 작성된 순으로 정해진 수 만큼 일기 가져오기
    func testGetRecentEntriesByMaxCount() {
        // Setup
        let diary = InMemoryDiary(entries: [Entry.dayBeforeYesterday, Entry.yesterday, Entry.today])
        
        // Run
        let entries = diary.recentEntries(max: 1)
        
        // Verify
//        XCTAssertEqual(entries.count, 1)
        expect(entries.count) == 1
//        XCTAssertEqual(entries, [Entry.today])
        expect(entries) == [Entry.today]
    }
    
    func testGetRecentEntriesByMinusMax() {
        // Setup
        let diary = InMemoryDiary(entries: [Entry.dayBeforeYesterday, Entry.yesterday, Entry.today])
        
        // Run
        let entries = diary.recentEntries(max: -1)
        
        // Verify
        expect(entries) == []
    }
    
    func testGetRecentEntriesAsManyAsStored() {
        // Setup
        let diary = InMemoryDiary(entries: [Entry.dayBeforeYesterday, Entry.yesterday, Entry.today])
//        let diary = InMemoryDiary(entries: [Entry.today, Entry.yesterday, Entry.dayBeforeYesterday])

        // Run
        let entries = diary.recentEntries(max: 10)
//        let entries = diary.recentEntries(max: -3)

        // Verify
//        XCTAssertEqual(entries.count, 3)
        expect(entries.count) == 3
        XCTAssertEqual(entries, [Entry.today, Entry.yesterday, Entry.dayBeforeYesterday])
        expect(entries) == [Entry.today, Entry.yesterday, Entry.dayBeforeYesterday]
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
