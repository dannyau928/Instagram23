//
//  PhotoStreamViewControllerTests.swift
//  Instagram23
//
//  Created by Danny Au on 8/10/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import XCTest

class PhotoStreamViewControllerTests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        app.launchArguments.append("MockFlag")
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTableViewRowCount() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.count > 0)
        XCTAssertTrue(tablesQuery.element(boundBy: 0).cells.count == 6)
    }

    func testTableViewCellAtIndexZero() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.count > 0)
        
        let photoStreamTable = tablesQuery.element(boundBy: 0)
        XCTAssertTrue(photoStreamTable.cells.count == 6)
        
        let cell = photoStreamTable.cells.element(boundBy: 0)
        XCTAssertEqual(cell.staticTexts["userName"].label, "mobile23_tester1")
        XCTAssertEqual(cell.buttons["likesCountButton"].label, "1 like")
    }

    func testTableViewCellAtIndexOne() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.count > 0)
        
        let photoStreamTable = tablesQuery.element(boundBy: 0)
        XCTAssertTrue(photoStreamTable.cells.count == 6)
        
        let cell = photoStreamTable.cells.element(boundBy: 1)
        XCTAssertEqual(cell.staticTexts["userName"].label, "mobile23_tester1")
        XCTAssertEqual(cell.buttons["likesCountButton"].label, "2 likes")
    }
}
