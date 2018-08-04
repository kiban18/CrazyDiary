//
//  CrazyDiaryTests.swift
//  CrazyDiaryTests
//
//  Created by LeeKihwan on 28/07/2018.
//  Copyright © 2018 Crazy Up Inc. All rights reserved.
//

import XCTest
@testable import CrazyDiary

class CrazyDiaryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_엔트리를_생성한다() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Setup
        let entry = Entry.init(id: 0, createdAt: Date(), content: "오늘은 기분이 좋다.", location: "서울")

        // Run
        entry.content = "오늘은 기분이 좋다.."
        
        // Verify
        XCTAssertEqual(entry.content, "오늘은 기분이 좋다..")
        
        // Teardown
        // TODO 위에 생성한 엔트리 삭제!

    }
    
    func testAddEntryToDiary() {
        // Setup
        let diary = InMemoryDiary()
        let newEntry = Entry(id: 1, createdAt: Date(), content: "일기", location: "대구")

        // Run
        diary.add(newEntry)
        
        // Verify
        let entryInJournal: Entry? = diary.entry(with: 1)
        
        XCTAssertEqual(entryInJournal, .some(newEntry)) // need Equatable
        XCTAssertTrue(entryInJournal === newEntry) // // 클래스 타입에만 사용 가능, 같은 데이터인지?
        XCTAssertTrue(entryInJournal?.isIdentical(to: newEntry) == true)
    }
    
    func testGetEntryWithId() {
        // Setup
        let oldEntry = Entry(id: 1, createdAt: Date(), content: "일기")
        let diary = InMemoryDiary(entries: [oldEntry])
        
        // Run
        let entry = diary.entry(with: 1)
        
        // Verify
        XCTAssertEqual(entry, .some(oldEntry))
        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
    }
    
    func testUpdateEntryPositive() {
        // Setup
        let oldEntry = Entry(id: 1, createdAt: Date(), content: "일기")
        let diary = InMemoryDiary(entries: [oldEntry])
        
        // Run
        oldEntry.content = "일기 내용을 수정했습니다."
        diary.update(oldEntry)
        
        // Verify
        let entry = diary.entry(with: 1)
        XCTAssertEqual(entry, .some(oldEntry)) // TODO: 어떤 의미?
        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
        XCTAssertEqual(entry?.content, .some("일기 내용을 수정했습니다."))
    }
    
    func testUpdateEntryNegative() {
        // Setup
        let oldEntry = Entry(id: 1, createdAt: Date(), content: "일기")
        let diary = InMemoryDiary(entries: [oldEntry])
        
        // Run
        oldEntry.content = "일기 내용을 수정했습니다."
        diary.update(oldEntry)
        
        // Verify
        let entry = diary.entry(with: 1)
        XCTAssertEqual(entry, .some(oldEntry)) // TODO: 어떤 의미?
        XCTAssertTrue(entry?.isIdentical(to: oldEntry) == true)
        XCTAssertNotEqual(entry?.content, .some("일기 내용이 달라졌어요."))
    }

    func testRemoveEntry() {
        // Setup
        let oldEntry = Entry(id: 2, createdAt: Date(), content: "지워질 일기")
        let diary = InMemoryDiary(entries: [oldEntry])
        
        // Run
        diary.remove(oldEntry)
        
        // Verify
        let entry = diary.entry(with: 2)
        XCTAssertNil(entry)
    }
    
    func test_최근_순으로_엔트리를_불러올_수_있다() {
        // Setup
        let dayBeforeYesterday = Entry(id: 1, createdAt: Date.distantPast, content: "그저께 일기")
        let yesterday = Entry(id: 2, createdAt: Date(), content: "어제 일기")
        let today = Entry(id: 3, createdAt: Date.distantFuture, content: "오늘 일기")
        
        let diary = InMemoryDiary(entries: [dayBeforeYesterday, yesterday, today])
        
        // Run
        let entries = diary.recentEntries(max: 3)
        
        // Verify
        XCTAssertEqual(entries.count, 3)
        XCTAssertEqual(entries, [today, yesterday, dayBeforeYesterday])
    }
    
    func test_요청한_엔트리의_수만큼_최신_순으로_반환한다() {
        // Setup
        let dayBeforeYesterday = Entry(id: 1, createdAt: Date.distantPast, content: "그저께 일기")
        let yesterday = Entry(id: 2, createdAt: Date(), content: "어제 일기")
        let today = Entry(id: 3, createdAt: Date.distantFuture, content: "오늘 일기")
        
        let diary = InMemoryDiary(entries: [dayBeforeYesterday, yesterday, today])
        
        // Run
        let entries = diary.recentEntries(max: 1)
        
        // Verify
        XCTAssertEqual(entries.count, 1)
        XCTAssertEqual(entries, [today])
    }
    
    func test_존재하는_엔트리보다_많은_수를_요청하면_존재하는_엔트리만큼만_반환한다() {
        // Setup
        let dayBeforeYesterday = Entry(id: 1, createdAt: Date.distantPast, content: "그저께 일기")
        let yesterday = Entry(id: 2, createdAt: Date(), content: "어제 일기")
        let today = Entry(id: 3, createdAt: Date.distantFuture, content: "오늘 일기")
        
        let diary = InMemoryDiary(entries: [dayBeforeYesterday, yesterday, today])
        
        // Run
//        let entries = diary.recentEntries(max: 10)
        let entries = diary.recentEntries(max: -3)

        // Verify
        XCTAssertEqual(entries.count, 3)
        XCTAssertEqual(entries, [today, yesterday, dayBeforeYesterday])
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
