//
//  PhotoLikesViewControllerTests.swift
//  Instagram23
//
//  Created by Danny Au on 8/10/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import XCTest

class PhotoLikesViewControllerTests: XCTestCase {
        
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
    
    func testPhotoLikesAtIndexZero() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.count > 0)
        
        let photoStreamTable = tablesQuery.element(boundBy: 0)
        XCTAssertTrue(photoStreamTable.cells.count == 6)
        
        let photoCell = photoStreamTable.cells.element(boundBy: 0)
        photoCell.buttons["likesCountButton"].tap()
        
        let likesTable = tablesQuery.element(boundBy: 0)
        XCTAssertTrue(likesTable.cells.count == 1)
        
        let likeCell = likesTable.cells.element(boundBy: 0)
        XCTAssertEqual(likeCell.staticTexts["userName"].label, "mobile23_tester1")
        XCTAssertEqual(likeCell.staticTexts["fullName"].label, "Tester231")
    }

    func testPhotoLikesAtIndexOne() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.count > 0)
        
        let photoStreamTable = tablesQuery.element(boundBy: 0)
        XCTAssertTrue(photoStreamTable.cells.count == 6)
        
        let photoCell = photoStreamTable.cells.element(boundBy: 1)
        photoCell.buttons["likesCountButton"].tap()
        
        let likesTable = tablesQuery.element(boundBy: 0)
        XCTAssertTrue(likesTable.cells.count == 2)
        
        let likeCellAtIndexZero = likesTable.cells.element(boundBy: 0)
        XCTAssertEqual(likeCellAtIndexZero.staticTexts["userName"].label, "mobile23_tester1")
        XCTAssertEqual(likeCellAtIndexZero.staticTexts["fullName"].label, "Tester231")
        
        let likeCellAtIndexOne = likesTable.cells.element(boundBy: 1)
        XCTAssertEqual(likeCellAtIndexOne.staticTexts["userName"].label, "mobile23_tester5")
        XCTAssertEqual(likeCellAtIndexOne.staticTexts["fullName"].label, "23andMobile 5")
    }
}
