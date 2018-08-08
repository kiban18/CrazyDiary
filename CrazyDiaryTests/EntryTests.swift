//
//  EntryTests.swift
//  CrazyDiaryTests
//
//  Created by LeeKihwan on 08/08/2018.
//  Copyright © 2018 Crazy Up Inc. All rights reserved.
//

import XCTest
import Nimble
@testable import CrazyDiary

class EntryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateEntry() {
        // Setup
        
        // Run
        let entry = Entry(id: 0, createdAt: Date(), text: "첫번째 일기")
        
        // Verify
        expect(entry.id) == 0
        expect(entry.id) != 1
        expect(entry.text) == "첫번째 일기"
        expect(entry.text) != "두번째 일기"
        expect(entry.createdAt) < Date()
        expect(entry.createdAt) != Date()
        expect(entry.modifiedAt).to(beNil())
        expect(entry.location).to(beNil())
    }
    
    func testCreateEntryWithLocation() {
        // Setup
        
        // Run
        let entry = Entry(id: 0, createdAt: Date(), text: "첫번째 일기", location: "부산")
        
        // Verify
        expect(entry.id) == 0
        expect(entry.id) != 1
        expect(entry.text) == "첫번째 일기"
        expect(entry.text) != "두번째 일기"
        expect(entry.createdAt) < Date()
        expect(entry.createdAt) != Date()
        expect(entry.modifiedAt).to(beNil())
        expect(entry.location).toNot(beNil())
        expect(entry.location) == "부산"
    }

    func testModifyEntry() {
        // Setup
        let entry = Entry(id: 0, createdAt: Date(), text: "처음 쓴 일기")

        // Run
        entry.text = "고쳐 쓴 일기"
        entry.location = "대구"
        
        // Verify
        expect(entry.id) == 0
        expect(entry.text) != "처음 쓴 일기"
        expect(entry.text) == "고쳐 쓴 일기"
        expect(entry.createdAt) != entry.modifiedAt
        //expect(entry.createdAt) < entry.modifiedAt // TODO: Value of optional type 'Date?' not unwrapped; did you mean to use '!' or '?'?
        expect(entry.createdAt) < entry.modifiedAt!
        //expect(entry.createdAt) < .some(entry.modifiedAt) // TODO: Cannot convert value of type 'Date' to expected argument type '_?'
        expect(entry.location).toNot(beNil())
        expect(entry.location) == "대구"
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
