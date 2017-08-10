//
//  ProfileViewControllerUITests.swift
//  Instagram23
//
//  Created by Danny Au on 8/10/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import XCTest

class ProfileViewControllerUITests: XCTestCase {
        
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
    
    func testProfilePage() {
        let app = XCUIApplication()
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["Profile"].tap()
        
        XCTAssertEqual(app.staticTexts["nameLabel"].label, "Tester231")
        XCTAssertEqual(app.staticTexts["followersLabel"].label, "0")
        XCTAssertEqual(app.staticTexts["followingLabel"].label, "1")
    }
}
