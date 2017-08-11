//
//  MockPhotoStream.swift
//  Instagram23
//
//  Created by Danny Au on 8/10/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import Foundation
import SwiftyJSON

class MockPhotoStream: PhotoStream {
    override class func getRecentMedia(_ callback: @escaping (_ photos: [Photo]?, _ error: NSError?) -> Void) -> Void {
        guard let path = Bundle.main.path(forResource: "RecentMedia", ofType: "json") else {
            callback(nil, NSError(domain: "MockPhotoStream.getRecentMedia", code: 0, userInfo: [KEY_MESSAGE : "failed to get path"]))
            return
        }
        
        guard let jsonString = try? String(contentsOfFile: path, encoding: .utf8) else {
            callback(nil, NSError(domain: "MockPhotoStream.getRecentMedia", code: 0, userInfo: [KEY_MESSAGE : "failed to get jsonString"]))
            return
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            callback(nil, NSError(domain: "MockPhotoStream.getRecentMedia", code: 0, userInfo: [KEY_MESSAGE : "failed to get jsonData"]))
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
    
    override class func getMediaLikes(_ id: String, _ callback: @escaping (_ users: [User]?, _ error: NSError?) -> Void) -> Void {
        guard let path = Bundle.main.path(forResource: "MediaLikes-\(id)", ofType: "json") else {
            callback(nil, NSError(domain: "MockPhotoStream.getMediaLikes", code: 0, userInfo: [KEY_MESSAGE : "failed to get path"]))
            return
        }
        
        guard let jsonString = try? String(contentsOfFile: path, encoding: .utf8) else {
            callback(nil, NSError(domain: "MockPhotoStream.getMediaLikes", code: 0, userInfo: [KEY_MESSAGE : "failed to get jsonString"]))
            return
        }
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            callback(nil, NSError(domain: "MockPhotoStream.getMediaLikes", code: 0, userInfo: [KEY_MESSAGE : "failed to get jsonData"]))
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

