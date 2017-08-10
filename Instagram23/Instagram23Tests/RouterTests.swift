//
//  RouterTests.swift
//  Instagram23
//
//  Created by Danny Au on 8/9/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import Alamofire
import XCTest
@testable import Instagram23

class RouterTests: XCTestCase {
    override func setUp() {
        super.setUp()
        
        Auth.accessToken = "TestAccessToken"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoginInstagram() {
        let urlRequestConvertible = Router.logInInstagram()

        let endpoint = "\(BASE_URL)/oauth/authorize/?client_id=\(CLIENT_ID)&redirect_uri=https%3A//www.23andme.com&response_type=token"
        let url = urlRequestConvertible.urlRequest?.url?.absoluteString
        XCTAssertEqual(endpoint, url)
        
        let httpMethod = urlRequestConvertible.urlRequest?.httpMethod
        XCTAssertEqual(httpMethod, Alamofire.HTTPMethod.get.rawValue)
    }
    
    func testGetUser() {
        let urlRequestConvertible = Router.getUser()

        let endpoint = "\(BASE_URL)/v1/users/self/?access_token=\(Auth.accessToken)"
        let url = urlRequestConvertible.urlRequest?.url?.absoluteString
        XCTAssertEqual(endpoint, url)
        
        let httpMethod = urlRequestConvertible.urlRequest?.httpMethod
        XCTAssertEqual(httpMethod, Alamofire.HTTPMethod.get.rawValue)
    }
    
    func testGetRecentMedia() {
        let urlRequestConvertible = Router.getRecentMedia()

        let endpoint = "\(BASE_URL)/v1/users/self/media/recent/?access_token=\(Auth.accessToken)"
        let url = urlRequestConvertible.urlRequest?.url?.absoluteString
        XCTAssertEqual(endpoint, url)
        
        let httpMethod = urlRequestConvertible.urlRequest?.httpMethod
        XCTAssertEqual(httpMethod, Alamofire.HTTPMethod.get.rawValue)
    }
    
    func testLikeMedia() {
        let testMediaId = "TestMediaId"
        let urlRequestConvertible = Router.likeMedia(testMediaId)

        let endpoint = "\(BASE_URL)/v1/media/\(testMediaId)/likes"
        let url = urlRequestConvertible.urlRequest?.url?.absoluteString
        XCTAssertEqual(endpoint, url)

        let httpMethod = urlRequestConvertible.urlRequest?.httpMethod
        XCTAssertEqual(httpMethod, Alamofire.HTTPMethod.post.rawValue)
        
        let data = "access_token=\(Auth.accessToken)&scope=public_content"
        var body = ""
        if let bodyData = urlRequestConvertible.urlRequest?.httpBody {
            body = String(data: bodyData, encoding: .utf8) ?? ""
        }
        XCTAssertEqual(data, body)
    }

    func testUnlikeMedia() {
        let testMediaId = "TestMediaId"
        let urlRequestConvertible = Router.unlikeMedia(testMediaId)
        
        let endpoint = "\(BASE_URL)/v1/media/\(testMediaId)/likes?access_token=\(Auth.accessToken)&scope=public_content"
        let url = urlRequestConvertible.urlRequest?.url?.absoluteString
        
        XCTAssertEqual(endpoint, url)
        
        let httpMethod = urlRequestConvertible.urlRequest?.httpMethod
        XCTAssertEqual(httpMethod, Alamofire.HTTPMethod.delete.rawValue)
    }
    
    func testGetMediaLikes() {
        let testMediaId = "TestMediaId"
        let urlRequestConvertible = Router.getMediaLikes(testMediaId)
        
        let endpoint = "\(BASE_URL)/v1/media/\(testMediaId)/likes?access_token=\(Auth.accessToken)&scope=public_content"
        let url = urlRequestConvertible.urlRequest?.url?.absoluteString
        
        XCTAssertEqual(endpoint, url)
        
        let httpMethod = urlRequestConvertible.urlRequest?.httpMethod
        XCTAssertEqual(httpMethod, Alamofire.HTTPMethod.get.rawValue)
    }
}
