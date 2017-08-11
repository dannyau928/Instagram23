//
//  AuthTests.swift
//  Instagram23
//
//  Created by Danny Au on 8/9/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import Alamofire
import SwiftyJSON
import XCTest
@testable import Instagram23

class AuthTests: XCTestCase {
    override func setUp() {
        super.setUp()
        IS_MOCKED = true
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGetUser() {
        let userExpectation = expectation(description: "get user")
        
        AuthManager.sharedInstance.getUser {(user, error) in
            XCTAssertNil(error)
            
            guard let user = user else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(user.id, "4141989283")
            XCTAssertEqual(user.userName, "mobile23_tester1")
            XCTAssertEqual(user.profilePicture, "https://scontent-mad1-1.cdninstagram.com/t51.2885-19/11906329_960233084022564_1448528159_a.jpg")
            XCTAssertEqual(user.fullName, "Tester231")
            XCTAssertEqual(user.follows, 1)
            XCTAssertEqual(user.followedBy, 0)
            
            userExpectation.fulfill()
        }
        
        wait(for: [userExpectation], timeout: 1)
        
/*
        guard let path = Bundle(for: type(of: self)).path(forResource: "User", ofType: "json") else {
            XCTFail()
            return
        }
        
        guard let jsonString = try? String(contentsOfFile: path, encoding: .utf8) else {
            XCTFail()
            return
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail()
            return
        }
        
        let jsonObj = JSON(data: jsonData)
        XCTAssertEqual(jsonObj[KEY_ID].string, "4141989283")
        XCTAssertEqual(jsonObj[KEY_USERNAME].string, "mobile23_tester1")
        XCTAssertEqual(jsonObj[KEY_PROFILE_PICTURE].string, "https://scontent-mad1-1.cdninstagram.com/t51.2885-19/11906329_960233084022564_1448528159_a.jpg")
        XCTAssertEqual(jsonObj[KEY_FULL_NAME].string, "Tester231")
        XCTAssertEqual(jsonObj[KEY_COUNTS][KEY_FOLLOWS].int, 1)
        XCTAssertEqual(jsonObj[KEY_COUNTS][KEY_FOLLOWED_BY].int, 0)
 */
    }
}
