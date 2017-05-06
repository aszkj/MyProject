//
//  weimiSnapshotUITests.swift
//  weimiSnapshotUITests
//
//  Created by ray on 16/3/4.
//  Copyright © 2016年 XKJH. All rights reserved.
//

import XCTest

class weimiSnapshotUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()

        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        snapshot("0Launch")

//        let app = XCUIApplication()
//        app.scrollViews.otherElements.icons["\u{552f}\u{79d8}"].tap()
//        app.buttons["keyboard"].tap()
//        snapshot("0Launch")
//        
//        app.navigationBars["\u{552f}\u{79d8}"].buttons["foundAvatar Main"].tap()
//        snapshot("0Launch")
//        
//        let tablesQuery = app.tables
//        tablesQuery.staticTexts["\u{8bbe}\u{7f6e}"].tap()
//        app.navigationBars["\u{8bbe}\u{7f6e}"].buttons["\u{4e2a}\u{4eba}\u{4e2d}\u{5fc3}"].tap()
//        tablesQuery.buttons["\u{7f16}\u{8f91}\u{8d44}\u{6599}"].tap()
//        snapshot("0Launch")
//
//        app.navigationBars["\u{7f16}\u{8f91}\u{8d44}\u{6599}"].buttons["navigation back"].tap()
//        
    }
    
}
