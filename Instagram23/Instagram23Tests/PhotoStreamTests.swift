//
//  PhotoStreamTests.swift
//  Instagram23
//
//  Created by Danny Au on 8/10/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import Alamofire
import SwiftyJSON
import XCTest
@testable import Instagram23

class PhotoStreamTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetUser() {
        class MockPhotoStream: PhotoStream {
            override class func getRecentMedia(_ callback: @escaping (_ photos: [Photo]?, _ error: NSError?) -> Void) -> Void {
                guard let path = Bundle(for: type(of: AuthTests().self)).path(forResource: "RecentMedia", ofType: "json") else {
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

                var photos = [Photo]()
                let jsonObj = JSON(data: jsonData)
                if let jsonArray = jsonObj.array {
                    for jsonPhoto in jsonArray {
                        photos.append(Photo(json: jsonPhoto))
                    }
                }
                callback(photos, nil)
            }
        }
        
        let recentMediaExpectation = expectation(description: "get recent media")
        
        MockPhotoStream.getRecentMedia({ (photos, error) in
            XCTAssertNil(error)
            
            guard let photos = photos else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(photos.count, 6)

            let photo = photos[0]
            XCTAssertEqual(photo.id, "1490910873554950190_4141989283")
            XCTAssertEqual(photo.userName, "mobile23_tester1")
            XCTAssertEqual(photo.profilePicture, "https://scontent-amt2-1.cdninstagram.com/t51.2885-19/11906329_960233084022564_1448528159_a.jpg")
            XCTAssertEqual(photo.lowResolution, "https://scontent.cdninstagram.com/t51.2885-15/s320x320/e35/17881498_444436879231374_515711381954101248_n.jpg")
            XCTAssertEqual(photo.standardResolution, "https://scontent.cdninstagram.com/t51.2885-15/s640x640/sh0.08/e35/17881498_444436879231374_515711381954101248_n.jpg")
            XCTAssertEqual(photo.userHasLiked, true)
            XCTAssertEqual(photo.likesCount, 1)
            
            recentMediaExpectation.fulfill()
        })
        
        wait(for: [recentMediaExpectation], timeout: 1)
    }
    
    func testGetMediaLikes() {
        class MockPhotoStream: PhotoStream {
            override class func getMediaLikes(_ id: String, _ callback: @escaping (_ users: [User]?, _ error: NSError?) -> Void) -> Void {
                guard let path = Bundle(for: type(of: AuthTests().self)).path(forResource: "MediaLikes", ofType: "json") else {
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
                
                var users = [User]()
                let jsonObj = JSON(data: jsonData)
                if let jsonArray = jsonObj.array {
                    for jsonUser in jsonArray {
                        users.append(User(json: jsonUser))
                    }
                }
                callback(users, nil)
            }
        }
        
        let recentMediaExpectation = expectation(description: "get recent media")
        
        MockPhotoStream.getMediaLikes("", { (users, error) in
            XCTAssertNil(error)
            
            guard let users = users else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(users.count, 1)
            
            let user = users[0]
            XCTAssertEqual(user.id, "4141989283")
            XCTAssertEqual(user.userName, "mobile23_tester1")
            XCTAssertEqual(user.fullName, "Tester231")
            XCTAssertEqual(user.profilePicture, "https://instagram.fymy1-1.fna.fbcdn.net/t51.2885-19/11906329_960233084022564_1448528159_a.jpg")
            
            recentMediaExpectation.fulfill()
        })
        
        wait(for: [recentMediaExpectation], timeout: 1)
    }
}
