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
        let entry = Entry.init(id: 1, createdAt: Date(), content: "오늘은 기분이 좋다.", location: "서울")

        // Run
        entry.content = "오늘은 기분이 좋다.."
        
        // Verify
        XCTAssertEqual(entry.content, "오늘은 기분이 좋다..")
        
        // Teardown
        // TODO 위에 생성한 엔트리 삭제!

    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
